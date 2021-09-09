# Ultimate Flutter App

## Contents

- Quiz App
- Personal Expense App
- Meals App
- Shop App
- Great Places App
- Chat App

## Indexes

- [Command Line Tools](#Command-line-tools)
- [Files and Folder Structure
  ](#Files-and-Folder-Structure)
- [Dart Basics](#Dart-Basics)
- [Analyze main.dart](#Analyze-maindart)

## Notes

- ### Command line tools

  ```bash
    # To create new project
    flutter create my_project_name

    # To check for missing requirements
    flutter doctor
  ```

- ### Files and Folder Structure

  | Folder/File      | Use                                                       | Development   |
  | ---------------- | --------------------------------------------------------- | ------------- |
  | .idea            | Used by android studio for development purposes           | Passive       |
  | android          | Android Project Folder for development and production     | Rarely Active |
  | ios              | IOS Project Folder for development and production         | Rarely Active |
  | build            | Holds output of flutter application                       | Passive       |
  | lib              | Contain our dart files                                    | Active        |
  | test             | Automate tests for app                                    | Rarely Active |
  | .gitignore       | Ignore files while committing and pushing to github       | Rarely Active |
  | .packages        | Auto Generated to manage internal dependency and packages | Passive       |
  | project_name.iml | Auto manage some internal functioning of flutter          | Passive       |
  | .metadata        | Flutter saves information used for building the app       | Passive       |
  | pubspec.yml      | Configure third party dependency, assets                  | Active        |
  | pubspec.lock     | Auto generated form pubspec.yml                           | Passive       |

  > Note: Active means used by programmer, Passive means Flutter manages automatically

- ### Dart Basics

  ```dart
    void main(){
      // Starting of program
      // Everything should be here
    }

    // Data types and Variables
    bool k = True; // or False
    int a = 1;
    double e = 10; // or 10.2002
    num d = 10; // or 10.2002
    String c = "Hello!";
    var f;

    // Functions
    int addNumbers(num a,num b){
      return a+b;
    }

    // Dynamic Function(bad practice)
    subNumbers(a,b){
      print(a-b);
    }

    // Class
    class Person{
      String name = "Ilene Dover";
      int age = 30;
    }

    var p1 = Person(); // Instantiate an object
    p1.name; // Access the object data

    // Constructor
    class Person{
      String name;
      int age;

      Person(String name, @required int age){
        this.name = name;
        this.age = age;
        // @required means age is compulsory to pass
        // and works only with Flutter
      }

      // Alternative
      Person({this.name,@required this.age});

      // Alternative(positioned argument)
      Person(this.name,@required this.age)
    }

    // Position doesn't matter in named parameter
    var p1 = Person(name: "Max", age: 20);
    // Position Matters
    var p2 = Person("Sam",20);

    // Arrow function(only if one statement is available)
    void main() => runApp(MyApp());

    // Execute function immediately
    onPressed: fxn()
    // Execute function only on certain event
    onPressed: fxn,

    // Anonymous function (execute only on certain event)
    onPressed: ()=>print("ans chosen!"),
    onPressed: (){
      // for other than one line statement
      print("ans chosen");
    },

    // Anonymous Function (execute immediately)
    onPressed: (){
      // for other than one line statement
      print("ans chosen");
    }(),

    // Private Properties(leading underscore to class or variable)
    // So we can't access them from other file
    class _Quiz{
      // Its a private class
    }
    var _qsnIndex = 0;

  ```

- ### Analyze main.dart

  ```dart
  // import needed packages from Flutter
  import 'package:flutter/material.dart';

  void main() {
    // runApp provided by material.dart
    // takes object which is MyApp() in this case
    // runs and calls build method of MyApp class
    runApp(MyApp());
  }

  // MyApp inherits StatelessWidget provided by Flutter or material.dart
  class MyApp extends StatelessWidget {
    // Define Class properties like variables and functions/methods in here

    @override // optional,  annotation used to mark an instance member as overriding an inherited class member

    // build method to return a Widget(class)
    // takes a required argument of type BuildContext
    // to handle location of widget in widget tree
    Widget build(BuildContext context) {
      // Define variables and functions that needs to reset and build when rebuilding the interface


      // MaterialApp is root widget
      return MaterialApp(
        home: Text("Hello"),
        body: Scaffold(),
      );
    }
  }
  ```

- ### Widgets

  ```dart
    // Widgets are classes with Constructor that takes named parameters
    // Widgets(), this is object of Widget Class
    // Press 'ctrl+space' inside () brackets of Widget to get the list of named parameters
    // Always add comma after each parameter to make the code pretty

    // Root Widget
    MaterialApp(
      // Scaffold is the base Styling Widget (backgroundColor, appBar , navigationBar)
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Ultimate Flutter App',
          ),
        ),
        body: Text("Body, You can add any Widget here!"),
      ),
    )

    // Layout and Control Widgets(Invisible)
    Row(), Column(), ListView(), Container(), ...

    // Output and Input Widgets(Visible)
    RaisedButton(), Text(), Card(), ... // Also Container() with some styling

    // Row() to arrange Widgets in Row
    Row(
      mainAxisAlignment: MainAxisAlignment.center, // horizontal axis
      crossAxisAlignment: CrossAxisAlignment.center, // vertical axis
      children: [
        Text("Row1"),
        Text("Row2"),
        Text("Row3"),
      ],
    ),

    // Column() to arrange Widgets in Column
    Column(
      mainAxisAlignment: MainAxisAlignment.center, // vertical axis
      crossAxisAlignment: CrossAxisAlignment.center, // horizontal axis
      children: [
        Text("Column1"),
        Text("Column2"),
        Text("Column3"),
      ],
    ),

    // ListView() to arrange Widgets in Row or Column but is Scrollable
    // Container() is like box-model of css
  ```

- ### Stateless vs Stateful Widget

  > In both, data can change externally and build method is called or the UI re-renders when data change

  | StatelessWidget                          | StatefulWidget                                          |
  | ---------------------------------------- | ------------------------------------------------------- |
  | Input Data -> Widget -> Renders UI       | Input Data -> Widget & Internal State -> Renders UI     |
  | Gets re-rendered when input data changes | Gets re-rendered when input data or local State changes |

  ```dart
    // StatefulWidget (combination of 2 classes)

    class Quiz extends StatefulWidget {
      @override
      // Setup connection to State class *
      _QuizState createState() => _QuizState();
    }

    // State is generic class
    // It is persistent and is attached to above StatefulWidget
    // Stores the state
    // State<Quiz> tells flutter that below State class belongs to Quiz class *
    class _QuizState extends State<Quiz> {
      setState((){
        // Write code that changes the UI
        // Calls build again but update only changed Widget
      });
      @override
      Widget build(BuildContext context) {}
    }
  ```
