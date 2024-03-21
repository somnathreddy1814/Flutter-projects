import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wechat/services/auth/auth_service.dart';

import '../../models/message.dart';

class ChatService{

  //get instance of fire store and auth
final FirebaseFirestore _firestore=FirebaseFirestore.instance;
final FirebaseAuth _auth=FirebaseAuth.instance;

  //get user stream
/*
list of maps
List<Map<String,dynamic>=
[
{
'email' : test@gmail.com
'id':..
},
{
'email' : thit@gmail.com
'id':..
},
]

Stream basically listens to out fire store
*/
 Stream<List<Map<String,dynamic>>>getUsersStream(){
   return _firestore.collection("Users").snapshots().map((snapshot){
     return snapshot.docs.map((doc){
       //go through individual user
       final user=doc.data();
       return user;
     }).toList();
   });
   }


  //send message
// Function to send a message
  Future<void> sendMessage(String receiverID, String message) async {
    // Get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // Create a new message
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    // Construct chat room ID for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); // Sort the ids (this ensures the chatroomID is the same for any 2 people)
    String chatRoomID = ids.join('_');

    // Add new message to database
    await _firestore
        .collection("chat rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }



  //get message
// Function to get messages between two users
  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    // Construct a chatroom ID for the two users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    // Return a stream of messages for the specified chat room
    return _firestore
        .collection("chat rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }


}