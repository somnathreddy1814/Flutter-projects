import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'screens/quiz_screen.dart';
import 'models/question.dart';

void main() {
  runApp(QuizoApp());
}

class QuizoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _loadQuestions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(title: Text('Loading Quiz')),
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(title: Text('Error')),
              body: Center(child: Text('Error loading questions')),
            );
          } else {
            List<Question> questions = snapshot.data as List<Question>;
            return QuizScreen(questions: questions);
          }
        },
      ),
    );
  }

  Future<List<Question>> _loadQuestions() async {
    String jsonString = await rootBundle.loadString('assets/questions.json');
    List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((data) => Question.fromJson(data)).toList();
  }
}
