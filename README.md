# Ultimate Flutter App

## Contents

- Flutter Notes
- Quiz App
- Personal Expense App
- Meals App
- Shop App
- Great Places App
- Chat App

## Index

[Flutter Basics(Quiz App)](#flutter-basicsquiz-app)

- [Command Line Tools](#command-line-tools)
- [Files and Folder Structure
  ](#files-and-folder-structure)
- [Dart and Flutter](#dart-and-flutter)
- [Analyze main.dart](#analyze-maindart)
- [Widgets](#widgets)
- [Stateless vs Stateful Widget](#stateless-vs-stateful-widget)
- [Github Workflow](#github-workflow)

[More Widgets, Styling, Adding Logic(Personal Expense App)](#more-widgets-styling-adding-logicpersonal-expense-app)

- [Adding Custom Assets](#adding-custom-assets)
- [Important Widgets](#important-widgets)
- [Access methods of StatefulWidget to connected State Widget](#access-methods-of-statefulwidget-to-connected-state-widget)

## Notes

## Flutter Basics(Quiz App)

- ### Command line tools

```bash
# To create new project
flutter create my_project_name

# To check for missing requirements
flutter doctor
```

**[⬆ Back to Index](#index)**

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

**[⬆ Back to Index](#index)**

- ### Dart and Flutter

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

if(expression){
  print("expression is true");
}else{
  print("expression is false ");
}

// Ternary Operator
expression ? print("expression is true") : print("expression is false");

// Null (to reset or indicate that any type of variable doesn't have a value)
var name; // default uninitialized variable is null
if(name == null){
  print("Name doesn't have any value")
}

// Private Properties(leading underscore to class or variable)
// So we can't access them from other file
class _Quiz{
  // Its a private class
}
var _qsnIndex = 0;
```

```dart
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

  Person(String name, required int age){
    this.name = name;
    this.age = age;
    // @required means age is compulsory to pass
    // and works only with Flutter
  }

  // Alternative
  Person({this.name,required this.age});

  // Alternative(positioned argument)
  Person(this.name,required this.age)
}

// Position doesn't matter in named parameter
var p1 = Person(name: "Max", age: 20);
// Position Matters
var p2 = Person("Sam",20);
```

```dart
// Multiple Constructors
class Person{
  String name;
  int age;

  Person.old(this.name){
    age = 60;
  }

  Person.young(this.name){
    age = 20;
  }
}

main(){
  Person.old("Max");
  print(Max.age)// 60
}
```

```dart
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
  fxn()
  print("ans chosen");
},

// Anonymous Function (execute immediately)
onPressed: (){
  // for other than one line statement
  fxn()
  print("ans chosen");
}(),
```

```dart
// Maps (key:value pairs)
var qsns = [
  {
    'qsn':'What is your favorite animal?',
    'ans' : ['Dog','Cat']
  },
  {
    'qsn':'What is your favorite color?',
    'ans' : ['Black','Red']
  }
];

qsns[0]['qsn'] // access 1st qsn
qsns[0]['ans'] // access 1st list of ans

// To get List of Answer Widgets
...(qsns[_qsnIndex]['ans'] as List<String>).map((ans) {
      return Answer(_ansQsn, ans);
    }).toList()

// qsns[_qsnIndex]['ans'] as List<String> -> dart doesn't know that ans is a list, So we need to specify it

// List.map((ans){}) -> iterate through every element inside the list and can take that element as argument

// return Answer(_ansQsn,ans); -> Based on iterations, Answer widgets are generated

// .toList() -> All the answer Widgets are converted back to list cause Column take list of Widgets

// ... -> spread operator takes a list and pull all values fo list and add them to surrounding list

// Example
Column(
  children : [
    ...(qsns[_qsnIndex]['ans'] as List<String>).map((ans) {
      return Answer(_ansQsn, ans);
    }).toList()
  ]
),

// Equivalent to (without ...spread operator)
Column(
  children : [
    [
      Answer(_ansQsn, qsns[_qsnIndex]['ans'][0]),
      Answer(_ansQsn, qsns[_qsnIndex]['ans'][1]),
    ]
  ]
),

// With ...spread operator (nested list got removed)
Column(
  children : [
      Answer(_ansQsn, qsns[_qsnIndex]['ans'][0]),
      Answer(_ansQsn, qsns[_qsnIndex]['ans'][2]),
  ]
),
```

```dart
const qsns; // values doesn't change, (compile-time constant)

final qsns; // values doesn't change once it receives initial value, (run-time constant) value

var txt = const ['Hello'] // value is constant but not variable, txt is unmodifiable
txt.add('Max');
print(txt); // error, if const is removed then, Hello Max
txt = ['Hello Max'] // allowed cause txt is not constant
```

```dart
// Getter(mixture of method and property), can't receive arguments
returnType get getterName {
  // do something
  return something;
}

getterName // call/reference to getter
```

```dart
// String Interpolation
a = 10;
print('a = $a'); // a = 10

tx.amount = 100; // tx is instance of a class with amount as property
print('amount =  \$${tx.amount}) // amount = $100
```

**[⬆ Back to Index](#index)**

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

**[⬆ Back to Index](#index)**

- ### Widgets

```dart// Widgets are classes with Constructor that takes named parameters
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

// RaisedButton(), FlatButton(), OutlineButton() are deprecated but can be used
// New Buttons are pre-styled but can be overwritten

// RaisedButton() to ElevatedButton()
ElevatedButton(
  onPressed: null,
  child: Text("Elevated Btn"),
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all(Colors.purple), // text and icon
    backgroundColor: MaterialStateProperty.all(Colors.red),
  ),

  // Alternative style Property
  style: ElevatedButton.styleFrom(
      primary: Colors.red, // bg (for elevated btn bg is primary thing)
      onPrimary: Colors.white, // foreground (what should be on primary)
    ),
),

// FlatButton() to TextButton()
TextButton(
  onPressed: null,
  child: Text("Text Btn"),
  style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.purple), // text and icon
  )

  // Alternative style property
  style: TextButton.styleFrom(
    primary: Colors.orange, // text (primary thing is text in TextButton)
  ),
),

// OutlineButton() to OutlinedButton()
OutlinedButton{
  onPressed: null,
  child: Text("Outlined Btn"),
  style: BorderStyle(),

  // Alternative style property
  style: OutlinedButton.styleFrom(
    primary: Colors.red // text
    side: BorderSide(
      color: Colors.black, // borderColor
    ),
  ),
}
```

**[⬆ Back to Index](#index)**

- ### Stateless vs Stateful Widget

> In both, data can change externally and build method is called or the UI re-renders when data change

| [StatelessWidget](#Analyze-maindart)     | StatefulWidget                                          |
| ---------------------------------------- | ------------------------------------------------------- |
| Input Data -> Widget -> Renders UI       | Input Data -> Widget & Internal State -> Renders UI     |
| Gets re-rendered when input data changes | Gets re-rendered when input data or local State changes |
| Immutable UI                             | Mutable UI                                              |

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

**[⬆ Back to Index](#index)**

- ### Github Workflow

Use Github Actions to auto build the github-pages as soon as you push to github.

1. Inside project folder or repository, add a new folder '/.github/workflows'.

<kbd>
  <img src='https://i.postimg.cc/FHcK1v6v/workflow-folder.png' border='1' alt='workflow-folder'/>
</kbd>

2. Under workflows, create publish.yaml file

```yaml
name: Gh-Pages

on:
  push:
    branches: [master]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2 # Only works with v2
      - uses: subosito/flutter-action@v1
      - uses: erickzanardo/flutter-gh-pages@v6
```

3. Commit and Publish it to github.
4. Navigate to 'actions' tab of the github repo. There, we can see the action going on.
5. After that action is completed, new branch 'gh-pages' will be created.
6. Go to 'Settings' of the repo, then 'Pages' and Under Branch: dropdown, select 'gh-pages'

<kbd>
  <img src='https://i.postimg.cc/j50WXXDp/github-pages.png' border='1' alt='github-pages'/>
</kbd>

7. Now the site will publish to
   'https://your_user_name.github.io/your_repo_nam'

> Note: In case you use custom url or the webpage reside in the root directory of custom url, below steps are not necessary

8. Now finally you have to open 'gh-pages' branch and change 'index.html'

9. Inside head tag find base url

```html
<head>
  .....
  <base href="/" />
  .....
</head>
```

10. Change base url to your repo name (or directory name in case of custom website)

```html
<head>
  .....
  <base href="/your-repo-name/" />
  .....
</head>
```

**Done**

**[⬆ Back to Index](#index)**

## More Widgets, Styling, Adding Logic(Personal Expense App)

- ### Adding Custom Assets

Use Custom fonts and images or any multimedia

1. Make a folder assets on root directory of project

```
  .
  ├── ...
  ├── assets       # root folder for all the assets to be used in your app
  │ ├── images     # All your images
  │ ├── fonts      # All you custom fonts
  └── ...
```

2. update pubspec.yml and save

```yml
flutter:
  assets:
    - assets/images/ # for images
  fonts:
    - family: CustomFont
      fonts:
        - asset: fonts/CustomFont-Regular.ttf
        - asset: fonts/CustomFont-Italic.ttf
          style: italic
    - family: CustomFont2
      fonts:
        - asset: fonts/CustomFont2.ttf
        - asset: fonts/CustomFont2.ttf
          weight: 700
```

3. Now assets can be used

```dart
Image.asset('assets/images/waiting.jpg') // using the image

Text(
  'Hello Peter!',
  style: TextStyle(fontFamily: 'CustomFont'), // using the font
);
```

**[⬆ Back to Index](#index)**

- ### Important Widgets

- App/Page Setup

```dart
// All Widget Wrapper
MaterialApp()
CupertinoApp()

// Styling overall app
Scaffold()
CupertinoPageScaffold()

```

- Layout

```dart
// Container()
// Wrapper for other widgets, alignment and styling(border, padding, margin) , takes one child, flexible size
// To style other Widgets
Container(
  margin: EdgeInsets.symmetric(
    vertical: 10,
    horizontal: 15,
  ),
  decoration: BoxDecoration(
    border: Border.all(
      color: Colors.purple,
      width: 2,
    ),
  ),
  padding: EdgeInsets.all(10),
  child: Text(
    '\$${tx.amount}',
    style: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: Colors.purple,
    ),
  ),
),

// Row()
// Arrange Widgets horizontally , takes multiple child , alignment only, takes full width
// Wrap with SingleChildScrollView() to avoid warning bars and make it scrollable
Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Widget(),
    Widget(),
    Widget(),
  ]
)

// Column()
// Arrange Widgets vertically , takes multiple child , alignment only , takes full height
// Wrap with SingleChildScrollView() to avoid warning bars and make it scrollable
Column(
  crossAxisAlignment: CrossAxisAlignment.end,
  children: [
    Widget(),
    Widget(),
    Widget(),
  ]
)
```

- Responsive Widgets

```dart
// FractionallySizedBox()
// Takes fraction of size of parent of any width
FractionallySizedBox(
  heightFactor: spendingPctOfTotal,
  child: Container(
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(10),
    ),
  ),
),

// Flexible()
// Like flexbox of CSS
// Control how a child of Row or Column or Flex flexes
Flexible(
  fit: FlexFit.tight, // force the child to fill the available space
  child:Text("hello"),
)

// Example of Flexible use case
Column(
  children: [
    Flexible(
      fit: FlexFit.tight, // takes remaining spaces
      // flex: 1; by default because of fit property, takes 1/3 part of available space
      child: Container(
        height: 100,
        color: Colors.blue,
      ),
    ),
    Flexible(
      flex:2, // takes 2/3 part of available space cause total flex = 1+2 = 3
      fit:FlexFit.loose, // takes width of child
      // because of loose, the size of Container is equal to size of child
      // but flex:2; will still be in account which may cause white spaces
      // if the child is smaller than 2/3 part of available space
      child: Container(
        height: 100,
        color: Colors.red,
      ),
    ),
    Container(
      // not flexible, so takes the width of its child
      height: 100,
      color: Colors.pink,
    ),
  ],
)

// FittedBox()
// Scales and positions its child Widget
// By default it shrinks the child if space is not enough
FittedBox(
  child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
),

// Expanded() is Flexible() with FlexFit.tight,
Expanded(
  // can have flex property
  child: Container(
    height: 100,
    color: Colors.blue,
  ),
),
```

- Content Containers

```dart
//Stack()
// Widgets on top of each other
Stack(
  children = [
    Widget(),
    Widget(),
  ]
)

// Card()
// Container with some default styling
// Needs Parent or Child for its size, eg: Container
Card(
  child: Text(),
)
```

- Repeat Elements

```dart
// ListView()
// Make contents Scrollable (either row or column)
// It is a Column() or Row() with SingleChildScrollView() but doesn't have fix size , have infinite size
// Wrap ListView() or ListView.builder() with Container with certain height, so that it will have a limited height (Container's height)
// ListView() renders children even when they are offscreen but ListView.builder() only renders what's visible
// ListView() for limited items and ListView.builder() fro many infinite items (or many)
ListView(children:[])

ListView.builder(
  itemBuilder: (ctx,index){
    return text(transaction[index].title); // build Children Widgets
  }
  itemCount: transaction.length, // Number of Widgets to be build
)

// List.generate()
// Generate 7 list items
List.generate(7, (index) {
  final weekDay = DateTime.now().subtract(Duration(days: index));
  var totalSum = transaction[index].amount;

  return {
    'day': DateFormat.E().format(weekDay).substring(0, 1), // gives short form of days' name (through intl package)
    'amount': totalSum,
  };
});

// ListTile()
// Used as return value for ListView()
ListTile(
  leading: Text('Left most element'),
  title: Text('Middle Top element'),
  subtitle: Text('Middle Bottom element'),
  trailing: Text('Right most element'),
),

// Align contents in both row and column
GridView()
```

- Content Types

```dart
// Text()
Text(
  '\$${transactions[index].amount.toStringAsFixed(2)}', // show number up to 2 decimal places
  style: TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: Colors.purple,
  ),
)

// Image()
// Add image from assets folder
Image.asset(
  'assets/images/empty.jpg',
  fit: BoxFit.cover, // squeeze the image to the size of parent
),


Icon()
```

- User Input

```dart
// TextField()
// Forms InputFields
// Two ways of accessing the input
// one with normal variable and onChanged or similar property
// other with TextEditingController
// String amountInput = '';
final amountController = TextEditingController();

TextField(
  decoration: InputDecoration(labelText: 'Amount'),
  // onChanged: (val) => amountInput = val,
  controller: amountController, // watch and store every input inside this TextField
  keyboardType: TextInputType.number, // only accepts numbers
  onSubmitted:(_)=>submitData, //_ means it takes argument but not needed
),

print(double.parse(amountController.text)); // prints text stored in controller as a double

// Buttons
RaisedButton()
FlatButton()
IconButton()

// GestureDetector()
// Detect gestures on the child
GestureDetector(
  onTap: () {},
  child: NewTransaction(_addNewTransaction),
  behavior: HitTestBehavior.opaque,
);

InkWell() // Gives ripple effect, to register event for double tap, tap on visible/invisible widgets
```

- Extra

```dart
// showModelBottomSheet()
// Slides from bottom
showModalBottomSheet(
  context: ctx,
  builder: (_) {
    return NewTransaction(_addNewTransaction);
  },
);

// ThemeData()
// Global theme for flutter app, declared inside MaterialApp widget with theme property
ThemeData(
  primarySwatch: Colors.blue, // Takes a color and auto-generate similar colors(shades) for other widgets
  accentColor: Colors.amberAccent,
  appBarTheme: AppBarTheme(
    textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontSize: 20,
          ),
        ),
  ),
  textTheme: ThemeData.light().textTheme.copyWith(
        headline1: TextStyle(
          fontSize: 16,
        ),
      ),
),

Text(
  "hello",
  style: TextStyle(
    color: Theme.of(context).primaryColor, // access global theme data
  ),
)

Text(
  "hello",
  style: Theme.of(context).textTheme.headline1,
),

// SizedBox()
// Empty spaces
SizedBox(
  height: 4,
  width: 10,
),

// CircleAvatar()
// Make the child round
CircleAvatar(
    child: Image(),
    radius: 30,
  ),
```

**[⬆ Back to Index](#index)**

- ### Access methods of StatefulWidget to connected State Widget

```dart
class NewTransaction extends StatelessWidget {
final Function addTx;
@override
_NewTransactionState createState() => _NewTransactionState();
}

class _ExpenseAppState extends State<ExpenseApp> {
void submit(){
  widget.addTx(); // widgets give access to class properties
  Navigator.push(context).pop(); // clear the current Widget or return back
}
@override
Widget build(BuildContext context) {
  return TextButton(
          child: Text('Add Transaction'),
          onPressed: submit,
        );
}
}
```

**[⬆ Back to Index](#index)**

- ### More Dart

```dart
// fold method reduces a collection to a single value by iteratively combining each element of the collection with an existing value
// List<Map<String, Object>> groupedTransactionValues;
groupedTransactionValues.fold(0.0, (previousValue, element) {
  return previousValue + (element['amount'] as double);
});

// where() allows to run a function on every item in the list, and if that function returns true, the item is kept in newly returned list
// tx.date.isAfter(other date) => if tx.date is after 'other date', it returns true
// DateTime.now() gives current date and time, .subtract subtracts current date and time with 7days
_userTransactions.where((tx) {
return tx.date.isAfter(
  DateTime.now().subtract(
    Duration(days: 7),
  ),// returns true if tx.date is after Today minus 7days
    // Only transaction younger than 7 days will be included
);

// Reverse a list
_userTransactions.reversed.toList();
```
