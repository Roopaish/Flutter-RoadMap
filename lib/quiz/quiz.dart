import 'package:flutter/material.dart';

import 'answer.dart';
import 'question.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  // List of String (questions)
  final qsns = [
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
        child: _qsnIndex < qsns.length
            ? Column(
                children: [
                  Question(
                    qsns[_qsnIndex]['qsn'] as String,
                  ),
                  ...(qsns[_qsnIndex]['ans'] as List<String>).map((ans) {
                    return Answer(_ansQsn, ans);
                  }).toList()
                ],
              )
            : Center(
                child: Text(
                  'You did it',
                ),
              ),
      ),
    );
  }
}
