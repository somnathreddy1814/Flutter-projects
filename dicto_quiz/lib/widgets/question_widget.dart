import 'package:flutter/material.dart';
import '../models/question.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;

  QuestionWidget(this.question);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question.questionText,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ...question.options.map((option) => ListTile(
          title: Text(option),
          leading: Radio(
            value: question.options.indexOf(option),
            groupValue: null, // Manage selected answer here
            onChanged: (value) {
              // Handle option selection
            },
          ),
        )),
      ],
    );
  }
}
