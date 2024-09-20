import 'package:flutter/material.dart';
import '../models/question.dart';

class ScoreScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final List<int> userAnswers;
  final List<Question> questions;

  ScoreScreen({
    required this.score,
    required this.totalQuestions,
    required this.userAnswers,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Score'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Score: $score/$totalQuestions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Answer Sheet:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  final userAnswer = userAnswers[index];
                  final isCorrect = userAnswer == question.correctAnswer;
                  return ListTile(
                    title: Text(question.questionText),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your Answer: ${question.options[userAnswer]}'),
                        Text('Correct Answer: ${question.options[question.correctAnswer]}'),
                        Text('Status: ${isCorrect ? 'Correct' : 'Incorrect'}'),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('Finish'),
            ),
          ],
        ),
      ),
    );
  }
}
