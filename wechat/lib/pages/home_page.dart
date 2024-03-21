import 'package:flutter/material.dart';
import 'package:wechat/services/auth/auth_service.dart';
import 'package:wechat/services/chat/chat_service.dart';

import '../components/my_drawer.dart';
import '../components/user_tile.dart';
import 'chat_page.dart';
class HomePage extends StatelessWidget {
   HomePage({super.key});

  final ChatService _chatService=ChatService();
  final AuthService _authService=AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
backgroundColor: Theme.of(context).colorScheme.primary,
        title:Padding(
          padding: EdgeInsets.only(left: 95),
            child: Text("H O M E")),
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }
  //build a list of users except for the currently logged in user
   Widget _buildUserList() {
     return StreamBuilder(
       stream: _chatService.getUsersStream(),
       builder: (context, snapshot) {
         // Handle error
         if (snapshot.hasError) {
           return const Text("Error");
         }

         // Show loading indicator
         if (snapshot.connectionState == ConnectionState.waiting) {
           return const Text("Loading..");
         }

         // Build list view with user data
         return ListView(
           children: (snapshot.data! as List<Map<String, dynamic>>)
               .map<Widget>((userData) => _buildUserListItem(userData,context))
               .toList(),
         );
       },
     );
   }
   // Function to build an individual list tile for a user
   Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    if(userData['email']!=_authService.getCurrentUser()!.email){
      // Return a UserTile widget to represent each user
      return UserTile(
        // Display the user's email as text on the tile
        text: userData["email"],
        // Define onTap behavior when the user tile is tapped
        onTap: () {
          // Navigate to the ChatPage when the user tile is tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatPage(receiverEmail: userData["email"],receiverID: userData["uid"],),),
          );
        },
      );
    }else{
return Container();
    }
   }


}
