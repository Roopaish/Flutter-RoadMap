import 'package:flutter/material.dart';
import 'models/meal.dart';
import 'screens/tabs_screen.dart';

class MealsApp extends StatefulWidget {
  final List<Meal> favoriteMeals;
  MealsApp(this.favoriteMeals);

  @override
  _MealsAppState createState() => _MealsAppState();
}

class _MealsAppState extends State<MealsApp> {
  @override
  Widget build(BuildContext context) {
    return TabsScreen(widget.favoriteMeals);
  }
}
