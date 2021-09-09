import 'package:flutter/material.dart';

import 'quizpanel.dart';
import 'result.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  // List of String (questions)
  final _qsns = [
    {
      'qsn': "What is your favorite animal?",
      'ans': [
        {'text': 'Dog', 'score': 1},
        {'text': 'Cat', 'score': 5},
        {'text': 'Penguin', 'score': 10},
      ],
    },
    {
      'qsn': "What is your favorite color?",
      'ans': [
        {'text': 'Black', 'score': 5},
        {'text': 'Red', 'score': 2},
        {'text': 'Orange', 'score': 5},
        {'text': 'White', 'score': 8},
      ],
    },
  ];

  var _qsnIndex = 0;
  var _totalScore = 0;

  void _ansQsn(int score) {
    _totalScore += score;
    setState(() {
      _qsnIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(minWidth: 100, maxWidth: 300),
        child: _qsnIndex < _qsns.length
            ? QuizPanel(
                ansQsn: _ansQsn,
                qsnIndex: _qsnIndex,
                qsns: _qsns,
              )
            : Result(_totalScore),
      ),
    );
  }
}
