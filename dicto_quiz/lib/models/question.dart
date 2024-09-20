import 'package:flutter/material.dart';

class Question {
  final int id;
  final String questionText;
  final List<String> options;
  final int correctAnswer;
  final String topic;

  Question({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    required this.topic,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      questionText: json['question_text'],
      options: List<String>.from(json['options']),
      correctAnswer: json['correct_answer'],
      topic: json['topic'],
    );
  }
}
