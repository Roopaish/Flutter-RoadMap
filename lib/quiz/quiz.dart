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
      'ans': ['Dog', 'Cat', 'Panda'],
    },
    {
      'qsn': "What is your favorite color?",
      'ans': ['Black', 'Red'],
    },
  ];
  var _qsnIndex = 0;

  void _ansQsn() {
    setState(() {
      _qsnIndex++;
    });
    print("ans pressed");
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
            : Result(),
      ),
    );
  }
}
