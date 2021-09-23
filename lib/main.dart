// import needed packages from Flutter
import 'package:flutter/material.dart';
import 'expense/expense.dart';
import 'meals/dummy_data.dart';
import 'meals/models/meal.dart';
import 'meals/screens/category_meals_screen.dart';
import 'meals/meals.dart';
import 'meals/screens/meal_detail_screen.dart';
import 'meals/screens/filters_screen.dart';
import 'quiz/quiz.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // For Meals-App
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // For Meals App
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = Dummy_Meals;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = Dummy_Meals.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(Dummy_Meals.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/meals-app',
      routes: {
        // Quiz App
        '/quiz-app': (context) => QuizApp(),
        // Expense App
        '/expense-app': (context) => ExpenseApp(),
        // Meals App
        '/meals-app': (context) => MealsApp(_favoriteMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_filters, _setFilters),
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
