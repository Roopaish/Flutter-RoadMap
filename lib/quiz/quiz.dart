import 'package:flutter/material.dart';

class Quiz extends StatelessWidget {
  void ansQsn() {
    print("ans pressed");
  }

  @override
  Widget build(BuildContext context) {
    // List of String (questions)
    var questions = [
      "What\'s you favourite color?",
      "What's your favourite animal?"
    ];

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              'Ultimate Flutter App',
            ),
          ),
          body: Column(
            children: [
              Text("Question"),
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
