import 'package:flutter/material.dart';

import 'answer.dart';
import 'question.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  var _qsnIndex = 0;

  void _ansQsn() {
    setState(() {
      _qsnIndex++;
    });
    print("ans pressed");
  }

  @override
  Widget build(BuildContext context) {
    // List of String (questions)
    var qsns = [
      {
        'qsn': "What is your favorite animal?",
        'ans': ['Dog', 'Cat', 'Panda'],
      },
      {
        'qsn': "What is your favorite color?",
        'ans': ['Black', 'Red'],
      },
    ];

    return Center(
      child: Container(
        constraints: BoxConstraints(minWidth: 100, maxWidth: 300),
        child: Column(
          children: [
            Question(
              qsns[_qsnIndex]['qsn'] as String,
            ),
            ...(qsns[_qsnIndex]['ans'] as List<String>).map((ans) {
              return Answer(_ansQsn, ans);
            }).toList()
          ],
        ),
      ),
    );
  }
}
