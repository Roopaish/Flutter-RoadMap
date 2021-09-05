# Ultimate Flutter App

## Contents
  - Quiz App
  - Personal Expense App
  - Meals App
  - Shop App
  - Great Places App
  - Chat App

## Notes

- ### Command line tools

  ```bash
    # To create new project
    flutter create my_project_name

    # To check for missing requirements
    flutter doctor
  ```

- ### Files and Folder Structure

  | Folder/File      	| Use                                                       	| Development   	|
  |------------------	|-----------------------------------------------------------	|---------------	|
  | .idea            	| Used by  android studio for  development  purposes        	| Passive       	|
  | android          	| Android Project Folder  for development and production    	| Rarely Active 	|
  | ios              	| IOS Project Folder for development and production         	| Rarely Active 	|
  | build            	| Holds output of flutter application                       	| Passive       	|
  | lib              	| Contain our dart files                                    	| Active        	|
  | test             	| Automate tests for app                                    	| Rarely Active 	|
  | .gitignore       	| Ignore files while committing and pushing to github       	| Rarely Active 	|
  | .packages        	| Auto Generated to manage internal dependency and packages 	| Passive       	|
  | project_name.iml 	| Auto manage some internal functioning of flutter          	| Passive       	|
  | .metadata        	| Flutter saves information used for building the app       	| Passive       	|
  | pubspec.yml      	| Configure third party dependency, assets                  	| Active        	|
  | pubspec.lock     	| Auto generated form pubspec.yml                           	| Passive       	|

  > Note: Active means used by programmer, Passive means Flutter manages automatically

- ### Analyze main.dart
      Widget Widget Widget

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
  ```
