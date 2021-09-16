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
      initialRoute: '/',
      routes: {
        '/quiz-app': (context) => QuizApp(),
        '/expense-app': (context) => ExpenseApp(),
      },
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) => GridView.count(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: [
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, '/quiz-app'),
              child: Text("Quiz App"),
            ),
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, '/expense-app'),
              child: Text("Expense App"),
            ),
          ],
        ),
      ),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.blueGrey,
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
                color: Colors.blue[900],
              ),
            ),
      ),
    );
  }
}
