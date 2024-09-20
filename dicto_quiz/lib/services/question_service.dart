import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/question.dart';

Future<List<Question>> loadQuestions() async {
  final String response = await rootBundle.loadString('assets/questions.json');
  final List<dynamic> data = json.decode(response);
  return data.map((json) => Question.fromJson(json)).toList();
}
