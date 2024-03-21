import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isCurrentUser ? Colors.green.shade400 : Colors.grey.shade500,
          borderRadius: BorderRadius.circular(12)
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      child: Text(
        message,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
