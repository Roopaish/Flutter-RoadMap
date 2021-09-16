// import needed packages from Flutter
import 'package:flutter/material.dart';
import 'expense/expense.dart';
import 'quiz/quiz.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExpenseApp(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepPurple[400],
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(
                fontSize: 16,
              ),
            ),
      ),
    );
  }
}
