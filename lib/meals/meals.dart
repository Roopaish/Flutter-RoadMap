import 'package:flutter/material.dart';
import 'screens/tabs_screen.dart';

class MealsApp extends StatefulWidget {
  const MealsApp({Key? key}) : super(key: key);

  @override
  _MealsAppState createState() => _MealsAppState();
}

class _MealsAppState extends State<MealsApp> {

  @override
  Widget build(BuildContext context) {
    return TabsScreen();
  }
}
