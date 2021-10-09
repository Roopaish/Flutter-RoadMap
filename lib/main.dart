// import needed packages from Flutter
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'quiz/quiz.dart';
import 'expense/expense.dart';

import 'meals/meals.dart';
import 'meals/models/meal.dart';
import 'meals/dummy_data.dart';
import 'meals/screens/category_meals_screen.dart';
import 'meals/screens/meal_detail_screen.dart';
import 'meals/screens/filters_screen.dart';

import 'shop/shop.dart';
import 'shop/screens/product_detail_screen.dart';
import 'shop/providers/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
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
    return ChangeNotifierProvider(
      // ChangeNotifierProvider (for Shop App only)
      create: (ctx) => Products(),
      child: MaterialApp(
        title: 'Flutter RoadMap',
        initialRoute: '/',
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
          // Shop App
          '/shop-app': (context) => ShopApp(),
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
        },
        debugShowCheckedModeBanner: false,
        home: AppList(),
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
      ),
    );
  }
}

// Listing apps on homescreen
class AppList extends StatefulWidget {
  @override
  _AppListState createState() => _AppListState();
}

class _AppListState extends State<AppList> {
  int _currentPage = 0;
  final Map albums = {
    'covers': [
      'https://i.postimg.cc/fbSHj92Q/quiz-app.png',
      'https://i.postimg.cc/13jCqHKK/expense-app.png',
      'https://i.postimg.cc/C5V7HMdh/meals-app.png',
    ],
    'title': ['Quiz App', 'Expense App', 'Meals App'],
    'routes': ['/quiz-app', '/expense-app', '/meals-app']
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 100),
            child: Container(
              key: UniqueKey(),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('${albums['covers'][_currentPage]}'),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10,
                  sigmaY: 10,
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ),
          ),
          FractionallySizedBox(
            heightFactor: 0.8,
            child: PageView.builder(
              itemCount: albums['covers'].length,
              onPageChanged: (value) {
                setState(() {
                  _currentPage = value;
                });
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed(albums['routes'][index]),
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('${albums['covers'][index]}'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              child: Text(
                                '${albums['title'][index]}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
              bottom: 20,
              child: Text('Scroll ->',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ))),
        ],
      ),
    );
  }
}
