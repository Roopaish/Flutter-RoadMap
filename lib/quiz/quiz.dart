import 'package:flutter/material.dart';

import 'quizpanel.dart';
import 'result.dart';
import 'data.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  var _qsnIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _qsnIndex = 0;
      _totalScore = 0;
    });
  }

  void _ansQsn(String ans, String chosenAns) {
    if (ans == chosenAns) {
      _totalScore += 1;
    }
    setState(() {
      _qsnIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(minWidth: 100, maxWidth: 800),
        child: _qsnIndex < qsns.length
            ? QuizPanel(
                ansQsn: _ansQsn,
                qsnIndex: _qsnIndex,
                qsns: qsns,
              )
            : Result(_totalScore, _resetQuiz),
      ),
    );
  }
}
