import 'package:flutter/material.dart';
import 'dart:async'; // For timer functionality
import '../models/question.dart';
import 'score_screen.dart';

class QuizScreen extends StatefulWidget {
  final List<Question> questions;

  QuizScreen({required this.questions});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late int _currentQuestionIndex;
  int _selectedAnswer = -1;
  int _score = 0;
  bool _isAnswered = false;
  late Timer _timer;
  int _remainingTime = 20;
  List<int> _userAnswers = [];

  @override
  void initState() {
    super.initState();
    _currentQuestionIndex = 0;
    _startTimer();
  }

  void _startTimer() {
    _remainingTime = 20; // 20 seconds for each question
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer.cancel();
        _nextQuestion();
      }
    });
  }

  void _submitAnswer(int selectedAnswer) {
    if (!_isAnswered) {
      setState(() {
        _selectedAnswer = selectedAnswer;
        _isAnswered = true;
        _userAnswers.add(selectedAnswer);
        if (_selectedAnswer == widget.questions[_currentQuestionIndex].correctAnswer) {
          _score++;
        }
      });
    }
  }

  void _nextQuestion() {
    _timer.cancel();
    if (_currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = -1;
        _isAnswered = false;
        _remainingTime = 20; // Reset the timer
        _startTimer();
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScoreScreen(
            score: _score,
            totalQuestions: 5,
            userAnswers: _userAnswers,
            questions: widget.questions.take(5).toList(), // Pass only the first 5 questions
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Question ${_currentQuestionIndex + 1}/5',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Time remaining: $_remainingTime seconds',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
            SizedBox(height: 20),
            Text(
              question.questionText,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ...question.options.asMap().entries.map((entry) {
              int index = entry.key;
              String option = entry.value;
              return ListTile(
                title: Text(option),
                leading: Radio<int>(
                  value: index,
                  groupValue: _selectedAnswer,
                  onChanged: _isAnswered
                      ? null
                      : (value) {
                    _submitAnswer(value!);
                  },
                ),
              );
            }).toList(),
            SizedBox(height: 20),
            if (_isAnswered)
              ElevatedButton(
                onPressed: _nextQuestion,
                child: Text('Next'),
              ),
          ],
        ),
      ),
    );
  }
}
