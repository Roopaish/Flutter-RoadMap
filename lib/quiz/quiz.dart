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
      "What\'s you favourite color?",
      "What's your favourite animal?"
    ];

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              'Quiz App',
            ),
          ),
          body: Column(
            children: [
              Question(
                qsns[_qsnIndex],
              ),
              Answer(_ansQsn),
              Answer(_ansQsn),
              Answer(_ansQsn),
            ],
          )),
    );
  }
}
