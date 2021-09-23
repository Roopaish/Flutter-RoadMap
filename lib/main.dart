// import needed packages from Flutter
import 'package:flutter/material.dart';
import 'expense/expense.dart';
import 'meals/screens/category_meals_screen.dart';
import 'meals/meals.dart';
import 'meals/screens/meal_detail_screen.dart';
import 'meals/screens/filters_screen.dart';
import 'quiz/quiz.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/meals-app',
      routes: {
        '/quiz-app': (context) => QuizApp(),
        '/expense-app': (context) => ExpenseApp(),
        '/meals-app': (context) => MealsApp(),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(),
        MealDetailScreen.routeName: (context) => MealDetailScreen(),
        FiltersScreen.routeName: (context) => FiltersScreen(),
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
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, '/meals-app'),
              child: Text("Meals App"),
            ),
          ],
        ),
      ),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.blueGrey,
        canvasColor: Color.fromRGBO(255, 255, 255, 1),
        fontFamily: 'Raleway',
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
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoCondensed',
              ),
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
            ),
      ),
    );
  }
}
