import 'package:flutter/material.dart';

import 'quizpanel.dart';
import 'result.dart';
import 'data.dart';

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
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
