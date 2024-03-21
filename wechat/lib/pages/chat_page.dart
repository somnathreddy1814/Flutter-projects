import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wechat/components/chat_bubble.dart';
import 'package:wechat/components/my_textfield.dart';
import 'package:wechat/services/auth/auth_service.dart';
import 'package:wechat/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  // Properties
  final String receiverEmail;
  final String receiverID;

  // Constructor
  ChatPage({
    Key? key,
    required this.receiverEmail,
    required this.receiverID,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
//text controller
  final TextEditingController _messageController = TextEditingController();

  //chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Add listener to the focus node
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        // Delay execution to allow time for keyboard to appear
        Future.delayed(
          const Duration(milliseconds: 500),
              () => scrollDown(), // Scroll down when focused
        );
      }
    });
    //wait a bit for listview to be built then scroll to bottom
    Future.delayed(Duration(microseconds: 500),
        ()=>scrollDown(),
    );
  }

  @override
  void dispose() {
    // Dispose the focus node and message controller
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }
// Scroll controller
  final ScrollController _scrollController = ScrollController();

// Function to scroll down to the bottom of the scrollable area
  void scrollDown() {
    // Animate scrolling to the bottom
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent, // Max scroll extent (bottom of the scrollable area)
      duration: const Duration(seconds: 1), // Animation duration
      curve: Curves.fastOutSlowIn, // Animation curve
    );
  }


  //send message
  void sendMessage() async {
    //if there is something inside the textfield
    if (_messageController.text.isNotEmpty) {
      //then we can send the message
      await _chatService.sendMessage(widget.receiverID, _messageController.text);
      //after sending message we clear the controller
      _messageController.clear();

    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      // Scaffold with an AppBar displaying the receiver's email as the title
      appBar: AppBar(
        title: Text(widget.receiverEmail),
        backgroundColor: Theme.of(context).colorScheme.primary,
        shadowColor: Theme.of(context).colorScheme.primary,
        elevation: 3,

      ),

      body: Column(
        children: [
          SizedBox(height: 10,),
          //display all the messages
          Expanded(
            child: _buildMessageList(),
          ),
          //user input
          _buildUserInput(),
        ],
      ),
    ); // Scaffold
  }

  //build message list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(widget.receiverID, senderID),
        builder: (context, snapshot) {
          //errors
          if (snapshot.hasError) {
            return Text("Error");
          }

          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading...");
          }

          //return list view
          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  // Function to build a message item widget
  Widget _buildMessageItem(DocumentSnapshot doc) {
    // Extract message data from the document snapshot
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Check if the sender is the current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    // Determine the alignment of the message based on whether the sender is the current user
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    // Return a container widget representing the message
    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data["message"], isCurrentUser: isCurrentUser)
        ],
      ),
    ); // Container
  }

  Widget _buildUserInput() {
    return Padding(
      padding: EdgeInsets.only(bottom: 40),
      child: Row(
        children: [
          Expanded(

            child: MyTextField(
              controller: _messageController,
              hintText: "Type a message",
              obscureText: false,
              focusNode: myFocusNode,
            ),
          ),

          //send button

          Container(
            decoration:
                BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle),
            margin: EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: Icon(Icons.arrow_upward,color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }
}
