// import needed packages from Flutter
import 'package:flutter/material.dart';
import 'quiz/quiz.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Ultimate Flutter App',
          ),
        ),
        body: Quiz(),
      ),
    );
  }
}
