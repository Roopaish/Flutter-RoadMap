import 'package:flutter/material.dart';

import 'question.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  var _qsnIndex = 0;

  void ansQsn() {
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
              ElevatedButton(
                onPressed: ansQsn,
                child: Text("ans 1"),
              ),
              ElevatedButton(
                onPressed: ansQsn,
                child: Text("ans 2"),
              ),
              ElevatedButton(
                onPressed: ansQsn,
                child: Text("ans 3"),
              ),
              ElevatedButton(
                onPressed: ansQsn,
                child: Text("ans 4"),
              ),
            ],
          )),
    );
  }
}
