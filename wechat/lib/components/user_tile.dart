import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  // Properties
  final String text;
  final void Function()? onTap;

  // Constructor
  const UserTile({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap event handler
      onTap: onTap,
      child: Container(
        // Styling for the container
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(vertical: 5,horizontal: 25),
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            // Icon placeholder
            SizedBox(width: 10,),
            Icon(Icons.person),
            //space between icon and user name
            SizedBox(width: 20,),
            // User name text
            Text(text),
          ], // Row children
        ), // Row
      ), // Container
    ); // GestureDetector
  }
}
