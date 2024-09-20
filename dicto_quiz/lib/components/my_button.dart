import 'package:flutter/material.dart';
import 'package:quizo/components/colors.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;

  const MyButton({
    super.key,
    required this.text,
    required this.onTap,

  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,

      child: Container(
        decoration: BoxDecoration(
          color: MyColors.first,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(11),
        margin: EdgeInsets.symmetric(horizontal: width*0.07),
        child: Center(
          child: Text(text,
            style: TextStyle(
                color:Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500
            ),
          ),
        ),
      ),
    );
  }
}