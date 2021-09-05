// import needed packages from Flutter
import 'package:flutter/material.dart';

void main() {
  // runApp provided by material.dart
  // takes object which is MyApp() in this case
  // runs and calls build method of MyApp class
  runApp(MyApp());
}

// MyApp inherits StatelessWidget provided my Flutter or material.dart
class MyApp extends StatelessWidget {
  // build method to return a Widget(class) 
  // takes argument of type BuildContext 
  // to handle location of widget in widget tree
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Text("Hello"),
    );
  }
}
