# [Ultimate Flutter App](https://roopaish.github.io/Ultimate-Flutter-App/#/)

## Contents

- [Flutter Notes](#notes)
- [Quiz App](https://roopaish.github.io/Ultimate-Flutter-App/#/quiz-app)
- [Personal Expense App](https://roopaish.github.io/Ultimate-Flutter-App/#/expense-app)
- [Meals App](https://roopaish.github.io/Ultimate-Flutter-App/#/meals-app)
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
- [Flutter Methods to show Widgets](#flutter-methods-to-show-widgets)
- [Access methods of StatefulWidget to connected State Widget](#access-methods-of-statefulwidget-to-connected-state-widget)
- [More Dart](#more-dart)

[Responsive and Adaptive UI](#responsive-and-adaptive-ui)

- [Media Query](#media-query)
- [Orientation](#orientation)
- [LayoutBuilder](#layoutbuilder)
- [Adaptive UI](#adaptive-ui)

[Flutter Internals and Performance](#flutter-internals-and-performance)

- [Flutter Under the Hood](#flutter-under-the-hood)
- [Avoid unnecessary Widget rebuild](#avoid-unnecessary-widget-rebuild)
- [Maintain Widgets](#maintain-widgets)
- [Widget Lifecycle](#widget-lifecycle)
- [App Lifecycle](#app-lifecycle)
- [Context](#context)
- [Key](#key)

[Navigation and Multiple Screens(Meals App)](#navigation-and-multiple-screensmeals-app)

- [Gradient](#gradient)
- [Navigator](#navigator)
- [TabBar](#tabbar)
- [BottomNavigationBar](#bottomnavigationbar)
- [Drawer](#drawer)
- [Stack of Pages](#stack-of-pages)
- [SwitchListTile](#switchlisttile)
- [Pass data through route](#pass-data-through-route)

[State Management (Shop App)](#State-management-shop-app)


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
  mainAxisSize: MainAxisSize.min, // size of row will be as big as its children need to be

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
  mainAxisSize: MainAxisSize.min, // size of column will be as big as its children need to be

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

// For Icons along with above buttons
// TextButton.icon(), ElevatedButton.icon(), OutlinedButton.icon()
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
  // context can be accessed here without passing from build method unlike stateless Widget
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
   'https://your_user_name.github.io/your_repo_name'

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
  softWrap: true, // wraps text
  overflow: TextOverflow.fade, // handle visual text overflow
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
**[⬆ Back to Index](#index)**

- Layout

```dart
// Container()
// Wrapper for other widgets, alignment and styling(border, padding, margin) , takes one child, flexible size
// To style other Widgets
Container(
  alignment: Alignment.centerLeft,
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
**[⬆ Back to Index](#index)**


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
**[⬆ Back to Index](#index)**


- Content Containers

```dart
//Stack()
// Widgets on top of each other
Stack(
  children = [
    Widget(),
    Widget(),
    Positioned( // only as a children of stack to position Widgets
      bottom: 20,
      right: 10,
      child: Container(),
    ),
  ]
)

// Card()
// Container with some default styling
// Needs Parent or Child for its size, eg: Container
Card(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(
      15,
    ),
  elevation: 4,
  child: Text(),
)
```
**[⬆ Back to Index](#index)**


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

// GridView()
// Align contents in both row and column
 GridView(
  padding: const EdgeInsets.all(25),
  children: [],
  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 200,
    childAspectRatio: 3 / 2, // for 200 width, height will be 300
    crossAxisSpacing: 20, // spacing between items
    mainAxisSpacing: 20,
  ),
  // Slivers are scrollable area on the screen and Grid is scrollable like ListView
  // gridDelegate provides layout for the grid
  // SliverGridDelegateWithMaxCrossAxisExtent allows to define max Width for each grid item
  // Grid will automatically fit as many items with 200px width on the provided screen

  // SliverGridDelegateWithFixedCrossAxisCount is used for showing defined number of items in the grid
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 3 / 2,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
  ),
)

// GridView.builder() for many elements 
GridView.builder(
  padding: const EdgeInsets.all(10),
  itemCount: products.length,
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 3 / 2,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
  ),
  
  // GridTile can be used anywhere but works well with GridView
  itemBuilder: (ctx, i) => GridTile(
      child: Image.network(ImageUrl),
      // GridTileBar is like ListTile
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        leading: IconButton(icon: Icon(Icons.favorite),onPressed: () {}, color: Colors.red),
        title: AnyWidget(),
        trailing: IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)
      ),
  ),
)
```
**[⬆ Back to Index](#index)**


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
  textAlign: TextAlign.center,
)

// Image()
// Add image from assets folder
Image.asset(
  'assets/images/empty.jpg',
  fit: BoxFit.cover, // squeeze the image to the size of parent
),

// Add image from url
Image.network(
  imageUrl,
  height: 250,
  width: double.infinity,
  fit: BoxFit.cover,
),


Icon(
  Icons.delete,
  size: 24,
)
```
**[⬆ Back to Index](#index)**


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
  decoration: InputDecoration(labelText: 'Amount'), // Placeholder
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
// Register event for double tap, tap on visible/invisible widgets
GestureDetector(
  onTap: () {},
  child: NewTransaction(_addNewTransaction),
  behavior: HitTestBehavior.opaque,
);

// InkWell()
// GestureDetector() with ripple effect
InkWell(
  onTap: (){},
  child: Text("Click"),
),
```
**[⬆ Back to Index](#index)**


- Extra

```dart
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

// Horizontal line
Divider(),

// CircleAvatar()
// Make the child round
CircleAvatar(
    child: Image(),
    radius: 30,
  ),

// manage border for child elements
// Clip Rounded Rectangle
ClipRRect(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(15),
    topRight: Radius.circular(15),
  ),
  child: Image.network(imageUrl),
),

// Switch()
var _showChart = true;
Switch(
  value: _showChart,
  onChanged: (val) { // val is true or false based on switching
    setState(() {
      _showChart = val;
    });
  },
),

_showChart ? Text('Switch is enabled'): Text('Switch is Disabled')
```

**[⬆ Back to Index](#index)**

- ### Flutter Methods to show Widgets

```dart
// showModelBottomSheet()
// Slides from bottom
showModalBottomSheet(
  context: ctx,
  builder: (_) {
    return AnyWidget();
  },
);

// showDatePicker()
showDatePicker(
  context: ctx,
  initialDate: DateTime.now(),
  firstDate: DateTime(2021),
  lastDate: DateTime.now(),
);
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

// Iterates and Returns only one item from the list when found and stops
final selectedMeal = Dummy_Meals.firstWhere((meal) => meal.id == mealId);

// Reverse a list
_userTransactions.reversed.toList();

// Remove item from list
_userTransactions.removeWhere((tx) => tx.id == id);

// Remove item at given index
_userTransactions.removeAt(existingIndex);

// get index of element on list
_userTransactions.indexWhere((tx) => tx.id == txId);

// add first element to list _favoriteMeals from Dummy_meals for which the fxn returns true
_favoriteMeals.add(Dummy_Meals.firstWhere((meal) => meal.id == mealId))

// Check condition for items in lists and stop if found any
_favoriteMeals.any((meal) => meal.id == id);

// Returns true if categories list has categoryId
categories.contains(categoryId)

// switch case
switch (compexity) {
  case Complexity.Simple:
    return 'Simple';
  case Complexity.Challenging:
    return 'Challenging';
  case Complexity.Hard:
    return 'Hard';
  default:
    return 'Unknown';
}
```

**[⬆ Back to Index](#index)**

## Responsive and Adaptive UI

Responsive for different screen sizes.
Adaptive for different operating system.

- ### Media Query

```dart
MediaQuery.of(context).size.height // get full height of screen
MediaQuery.of(context).size.width // get full width of screen
appBar.preferredSize.height // get height of certain widget, appBar is final variable with AppBar Widget
MediaQuery.of(context).padding.top // get height of status bar
MediaQuery.of(context).viewInsets.bottom // size of anything that's lapping in our view, eg: keyboard pops up when we type overlapping certain parts of app
SafeArea() // Wrap full app body with this to avoid widgets getting in System status bar or bottom navigation bar
```

**[⬆ Back to Index](#index)**

- ### Orientation

```dart
// Force portrait mode even if screen is rotated
import 'package:flutter/services.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    ]); // Disable landscape mode
  runApp(MyApp());
}

// To render a widget on condition
final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
if(isLandscape) Widget(),
if(isLandscape)  _usersTransaction.isEmpty ? Widget1() : Widget2() // Render Widget2 if device is on landscape mode and _userTransactions is not empty
```

**[⬆ Back to Index](#index)**

- ### LayoutBuilder

To get the space available for a given Widget in the overall app

```dart
// constraints is an object containing height and width of widget
LayoutBuilder(builder: (ctx, constraints) {
  return Column(
    children: [
      Container(height: constraints.maxHeight * 0.15,) // take 15 % of given height
      Container(height: constraints.maxWidth * 0.15,) // take 15 % of given width
    ]
  );
}
```

**[⬆ Back to Index](#index)**

- ### Adaptive UI

```dart
Switch.adaptive() // Render switch based on OS

// To know platforms where app is running
import 'dart:io';

Platform.isIOS // Boolean, True is OS is IOS else false
Platform.isAndroid
Platform.isLinux
Platform.isMacOS
Platform.isWindows

// Cupertino Widgets
import 'package:flutter/cupertino.dart';

CupertinoApp( // MaterialApp() alternative
  home: CupertinoPageScaffold( // Scaffold alternative
    child: pageBody,
    navigationBar: CupertinoNavigationBar( // AppBar() alternative
      middle: Text('Expense App'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => _startAddNewTransaction(context),
          ),
        ],
      ),
    ),
  ),
)

CupertinoTextField(placeholder: 'placeholder',)

CupertinoButton(
  child: Text(
    'Choose Date'
  ),
  style: TextStyle(),
  onPressed: (){},
)

// Custom Adaptive Widget
// Create a adaptive_widget.dart file
// Create Different Adaptive Widgets by checking platform and defining widgets accordingly
// Use them on other files, using  their constructors
// Avoiding duplication
```

**[⬆ Back to Index](#index)**

## Flutter Internals and Performance

- ### Flutter Under the Hood

Flutter paints the UI 60fps. If some information is not change flutter takes the old info and paints on the screen which is fast and very efficient when refreshing the UI.

Widget Tree => configuration (rebuilds frequently)  
ELement Tree => Links widgets' rendered objects (rarely rebuild))  
Render Tree => Rendered objects on the screen (rarely rebuilds)

Element is a object managed by flutter in memory which holds the reference to Widgets.
Element is created for all widgets.

On encountering a StatefulWidget, it creates an Element and then it also calls the createState method to create State Object which is also connected to Element.
So One StatefulElement holds reference to both StatefulWidget and State Object.
When setState() is called, old StatefulWidget is replaced by new StatefulWidget but State object is same. Same happens to all child widget. Old reference is updated but if some data is same, then only data that has been changed is re-rendered.

Element which hasn't been rendered to the screen yet, is rendered to the screen. SO Element has pointer to Element on the Screen and Widget holding Configuration.

build method is triggered when setState is invoked ,UI refreshes ,MediaQuery changes or softKeyboard appears.

Widgets are objects of classes which have their own build method which is triggered when new instance of Widget Classes are created.  
So first constructor is called then build method is invoked when we create new instance of Widgets.

**[⬆ Back to Index](#index)**

- ### Avoid unnecessary Widget rebuild

For bigger apps, it can boost performance.  
Using const constructors for Widgets which doesn't change(immutable) will not recreate object(Widget) when re-build.  
This doesn't work with dynamic values for Class property.

```dart
const Text("This never change and the text is not dynamic."),
const CharBar(this.label,this.fxn),
```

**[⬆ Back to Index](#index)**

- ### Maintain Widgets

Extract Widgets

Extracting Widgets makes the code readable but can also boost some performance in some cases.  
Eg: If certain number of widgets depends on MediaQuery, it is good to make a separate widget containing those widgets.

Builder Methods

```dart
// Define a fxn to build certain part of app
Widget _buildLandscapeContent(){
  return Container();
}

List<Widget> _buildTransactionList(MediaQueryDta media){
  return [ListTile(), Container()];
}

// Use the content in builder fxn
if(isLandscape) _buildLandscapeContent(),
```

**[⬆ Back to Index](#index)**

- ### Widget Lifecycle

Stateless Widget : Constructor() -> build()

Stateful Widget : WidgetConstructor() -> createState() -> StateConstructor() -> initState() -> build(), setState() -> didUpdateWidget() -> build(), dispose()  
initState() runs when State object is created for the first time  
didUpdateWidget() in State object is triggered when the widget belonging to this state is updated  
dispose() runs when Widget is destroyed

Only the WidgetConstructor is called when creating new instance of Stateful Widget afterward i.e. createState() -> StateConstructor() -> initState() this does not happen again. It means the State is not recreated when Widget rebuilds automatically instead it sticks around and hold reference of the element which manages the State and is updated to point at the new Widget.

```dart
// Inside State class
// @override because these exists in parent class and we are deliberately changing them
// super refers to parent object
@override
void initState(){
  super.initState(); // runs initState() of parent State
  // execute as soon as State Object is created
  // used for fetching initial data for app
}

@override
void didUpdateWidget(NewTransaction oldWidget){
  super.didUpdateWidget(oldWidget); // runs didUpdateWidget() of parent State
  // execute when the Widget changes or rebuilds
  // less used
  // to refetch data or fetch new data
}

@override
void dispose(){
  super.dispose(); // runs dispose() of parent State
  // execute when Widget leaves the screen
  // used for cleaning up
  // like cleaning up connection with server when not needed
}

@override
  void didChangeDependencies() {
    // can be used instead of initState when we require context of State
    // cause initState runs before build, so context is not available
    // this fxn also runs before build, but we can access context anyway
    super.didChangeDependencies();
  }
```

**[⬆ Back to Index](#index)**

- ### App Lifecycle

Lifecycle State Name  
inactive : App is inactive(not in background), no user input received but not fully cleared from memory  
paused : App is not visible to user but running in background  
resumed : App is again visible, responds to user inputs  
suspending : App is about to be suspended

Listen to App Cycle events

```dart
class _Chart extends State<Chart> with WidgetsBindingObserver{
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // when AppLifecycle changes it goes to certain observer and calls didChangeAppLifecycleState() method
    // this means this class
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    // called when AppLifecycle changes
    print(state); // prints AppLifecycleState.paused if app is on recent
  }

  @override
  dispose(){
    super.dispose() ;
    WidgetsBinding.instance.removeObserver(this); // to avoid memory leaks
    // to clear all listener for AppLifecycle changes
    // Don't do it in main State Widget which will shutdown the whole app
    // Do in child Widget
  }
}
```

**[⬆ Back to Index](#index)**

- ### Context

Every widget has its own context attached to it. Context stores meta information on the Widget and its location in the Widget Tree.
Skeleton of widget tree.

Context know about each other, they know where Widgets are and what other widgets revolve around them.  
They communicate with each other.

Context has all the information about position of widget, overall Widget tree and establish direct communication between channels behind the scenes to exchange data between Widgets.

**[⬆ Back to Index](#index)**

- ### Key

Most Widgets don't need a key specially Stateless Widget.

Example where we need it: Lists and Stateful Widgets  
Widget Tree (Widgets from top to bottom) : ListView(children:[item1, item2])

Element Tree (Reference to above Widgets):
&ListView(reference to ListView Widget which hold info about its children too)  
&item1(reference to both item1 StatefulWidget and State Object)  
&item2(reference to both item2 StatefulWidget and State Object)

When item1 is deleted.  
Flutter checks from top to bottom.  
First &ListView and ListView are checked. If both present, its items in ListView are checked.  
Secondly, item is checked in the same level as item1(which is deleted). Since its a list,item2 moves up to the place left by item1. So Flutter answer as yes cause it finds an item where old item was.  
So now &item1 update reference to the item2.

Now &item2 does not find any fitting Widget as item2 move up, so &item2 is deleted along its State.

Solution: Using keys will delete both item1 and &item1 when item1 is deleted.
TL;DR: Without key, FLutter checks the type of Widget that ELement is referencing to.  
 With key, Flutter checks the Widget with certain key value that is equal to key value of Element.  
 Key helps to identify connected Widget with key value rather than the type of Widget.

```dart
import 'dart:math'; // for Random class
Color _chosenColor;

@override
void initState(){
  const availableColors = [Colors.blue, Colors.red, Colors.purple ];
  // generate random between 0, 1, 2, 3
  _bgColor = availableColors[Random().nextInt(4)] // assigned to background color for List Items
  // Doesn't need to wrap in setState() cause initState() is called before build method
  super.initState();
}

ListView(
  children: transaction.map((tx) => TransactionItem(key: ValueKey(tx.id), transaction: tx)).toList(),
  // key should be defined for parent Widget
  // key: UniqueKey() generate unique key to identify each items for every build or change in state of UI
  // key: ValueKey(id) give provided key or id which does not changes
)

class TransactionItem extends StatefulWidget{
  const TransactionItem({Key key, @required this.transaction}) : super(key: key);
  // super forward key of TransactionItem to StatefulWidget key, so it knows what to do with it, its a constructor for StatefulWIdget (parent Widget)
  ...
  ...
}

```

**[⬆ Back to Index](#index)**

## Navigation and Multiple Screens(Meals App)

- ### Gradient

```dart
// LinearGradient() gives gradient background for the container
Container(
padding: const EdgeInsets.all(15),
child: Text(title),
decoration: BoxDecoration(
  gradient: LinearGradient(
    colors: [
      color.withOpacity(0.7),
      color,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  borderRadius: BorderRadius.circular(15),
),
)
```

**[⬆ Back to Index](#index)**

- ### Navigator

```dart
// Navigate between pages
// Needs to be connected to context, to know what current screen is and to know what to add on top of it or remove

// add new page on top of current page, transition to CategoryMealsScreen() from current page
// Back button will be added automatically in CategoryMealsScreen()
Navigator.of(ctx).push(
  MaterialPageRoute(
    builder: (_) {
      return CategoryMealsScreen();
    },
  ),
);
```

```dart
// Named Routes
// Switch to CategoriesMealsScreen() and also pass data without constructor through map
// 1st define the routes
MaterialApp(
  routes: {
    '/categories': (context) => CategoriesScreen
    '/category-meals': (context) => CategoriesMealsScreen(),
  }
),

// 2nd Create Navigator for the defined route and pass the arguments
Navigator.of(context).pushNamed('/category-meals', arguments: {
  'id': id,
  'title': title,
});

//3rd Access arguments inside build method of CategoriesMealsScreen() Widget
final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
final categoryTitle = routeArgs['title'];
final categoryId = routeArgs['id'];
```

```dart
// Properties of MaterialApp(), onGenerate and unUnkown takes settings about the route and returns a route
// CategoriesScreen() will appear for any route that is not registered in routes: (for named Routes)
onGenerateRoute: (settings){
  if(settings.name == '/meal-detail'){
  return MaterialPageRoute(builder:(ctx) => MealScreen());
  }
  return MaterialPageRoute(builder:(ctx) => CategoriesScreen());
}

// When certain page can't be found
// Can be used for 404 error screen
onUnknownRoute:(settings){
  if(settings.name == '/meal-detail'){
  return MaterialPageRoute(builder:(ctx) => MealScreen());
  }
  return MaterialPageRoute(builder:(ctx) => CategoriesScreen());
}
```

```dart
Navigator.of(context).pop(); // get rid of current page or return back
Navigator.of(context).popAndPushNamed('/meals-app'); // pop and push to new page
Navigator.of(context).canPop(); // check if you can go back, (is there something below this on stack)

// pop and send some arguments to the new page
// popping statement
Navigator.of(context).pop(id);

// pushing and receiving the result i.e. id from the popped page to a new page(or page that is one step below in stack)
// .then fxn runs when a page i.e. MealDetailScreen is popped
Navigator.of(context)
    .pushNamed(
  MealDetailScreen.routeName,
  arguments: id,
)
    .then((result) {
  print(result);
});
```

**[⬆ Back to Index](#index)**

- ### TabBar

```dart
// The widget can be either stateful or stateless
// DefaultTabController is needed for TabBar below AppBar
DefaultTabController(
  initialIndex: 1, // Start screen with favorite, default is 0
  length: 2,
  child: Scaffold(
    appBar: AppBar(
      title: Text('Meals'),
      bottom: TabBar(
        tabs: [
          Tab(
            icon: Icon(Icons.category),
            text: "Categories",
          ),
          Tab(
            icon: Icon(Icons.favorite),
            text: "Favorites",
          ),
        ],
      ),
    ),
    body: TabBarView(
      // Children must match the order of tabs defined above in TabBar()
      children:[
        CategoriesScreen(),
        FavoritesScreen(),
      ],
    ),
  ),
)
```

**[⬆ Back to Index](#index)**

- ### BottomNavigationBar

```dart
// Should be StatefulWidget
class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _pages = [
    {'page': CategoriesScreen(), 'title': 'Categories'},
    {'page': FavoritesScreen(), 'title': 'Favorites'},
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String),
      ),
      drawer: Drawer(

      ),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.shifting,
        // type animates the switching between tabs
        // Items should be styled differently
        // i.e. backgroundColor of BottomNavigationBar does not work in BottomNavigationBarItem, so they should have their own backgroundColor
        items: [
          BottomNavigationBarItem(
            // backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            // backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
```

**[⬆ Back to Index](#index)**

- ### Drawer

```dart
Scaffold(
  drawer: Drawer(
    child: Container(),
  ),
),
```

**[⬆ Back to Index](#index)**

- ### Stack of Pages

```dart
// Navigating from page1 to page2 creates a stack where page1 is under page 2
// and then returning back to page1 with back button, will clear the page2 in the stack
// i.e page2 is replaced by page1, Thus optimizing performance

// But Navigating from page1 to page2 and then to page1 again through some link can create stack of page1|page2|page1
// here, previous page1 and page2 doesn't get cleared from the stack
// i.e. New page is added on top of each other instead of replacing, Thus performance can be degraded

// instead of push and pushName, we use pushReplacement and pushReplacementNamed respectively to solve this issue
// there will be no back button or you won't be able to go back cause there's nothing on stack
// Can be used for logging into the app, where once logged in you can't go back to login screen
Navigator.of(context).pushReplacement();
Navigator.of(context).pushReplacementNamed();
```

> VoidCallback = void Function

**[⬆ Back to Index](#index)**

- ### SwitchListTile

```dart
// ListTile with trailing Switch
SwitchListTile(
  title: Text('Gluten-free'),
  value: _glutenFree,
  subtitle: Text('Only include glute-free meals'),
  onChanged: (newValue) {
    setState(() {
      _glutenFree = newValue;
    });
  },
),
```

**[⬆ Back to Index](#index)**

- ### Pass data through route

```dart
// Passing _setFilter fxn from main app screen to FiltersScreen
MaterialApp(
  routes: {
    FilterScreen.routename: (ctx) => FiltersScreen(_setFilters),
  }
)

// In FiltersScreen Widget
final Function saveFilters;
FiltersScreen(this.saveFilters)
```

**[⬆ Back to Index](#index)**


## State Management (Shop App)

- Problem with routes created on the fly

Passing data through routes created on fly when required can make it hard to manage the project.  
We have to pass data through constructors. So, if page1 has data1 which is transferred to page2 (where data1 is not used) then to page3 (where data1 will be used). So it's not an ideal way of transferring data.


