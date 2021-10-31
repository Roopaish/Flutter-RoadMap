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
import 'shop/providers/cart.dart';
import 'shop/providers/auth.dart';
import 'shop/screens/cart_screen.dart';
import 'shop/providers/orders.dart';
import 'shop/screens/orders_screen.dart';
import 'shop/screens/user_products_screen.dart';
import 'shop/screens/edit_product_screen.dart';
import 'shop/screens/auth_screen.dart';
import 'shop/helpers/custom-route.dart';

import 'great_places/great_places.dart';
import 'great_places/providers/great_places.dart';
import 'great_places/screens/add_place_screen.dart';
import 'great_places/screens/place_detail_screen.dart';

import 'chat/chat.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Meals App
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
    return MultiProvider(
      providers: [
        // Shop App
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products('', '', []),
          update: (ctx, auth, previousProducts) => Products(
              auth.token,
              auth.userId,
              previousProducts == null ? [] : previousProducts.items),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders('', '', []),
          update: (_, auth, previousOrder) => Orders(
            auth.token,
            auth.userId,
            previousOrder == null ? [] : previousOrder.orders,
          ),
        ),
        // Great Places App
        ChangeNotifierProvider(
          create: (ctx) => GreatPlaces(),
        )
      ],
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
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          UserProductsScreen.routeName: (context) => UserProductsScreen(),
          EditProductScreen.routeName: (context) => EditProductScreen(),
          AuthScreen.routeName: (context) => AuthScreen(),
          // Greate Places App
          '/greate-places-app': (context) => GreatPlacesApp(),
          AddPlaceScreen.routeName: (context) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (context) => PlaceDetailScreen(),
          // Chat App
          '/chat-app': (context) => ChatApp(),
        },
        debugShowCheckedModeBanner: false,
        home: AppList(),
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          backgroundColor: Colors.deepPurple,
          accentColor: Colors.blueGrey,
          accentColorBrightness: Brightness.dark,
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.indigo,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
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
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CustomPageTransitionBuilder(),
            TargetPlatform.iOS: CustomPageTransitionBuilder(),
            TargetPlatform.windows: CustomPageTransitionBuilder(),
            TargetPlatform.linux: CustomPageTransitionBuilder(),
            TargetPlatform.macOS: CustomPageTransitionBuilder(),
          }),
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
  String appName = 'Quiz App';
  final Map albums = {
    'covers': [
      'https://i.postimg.cc/fbSHj92Q/quiz-app.png',
      'https://i.postimg.cc/13jCqHKK/expense-app.png',
      'https://i.postimg.cc/C5V7HMdh/meals-app.png',
      'https://i.postimg.cc/vH8R3B4r/shop-app.png',
      'https://i.postimg.cc/MK5WL2Tq/great-places-app.png',
      'https://i.postimg.cc/7LTXsTTL/chat-app.png',
    ],
    'title': [
      'Quiz App',
      'Expense App',
      'Meals App',
      'Shop App',
      'Great Places App',
      'Chat App'
    ],
    'routes': [
      '/quiz-app',
      '/expense-app',
      '/meals-app',
      '/shop-app',
      '/greate-places-app',
      '/chat-app'
    ]
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
          Container(
            constraints: BoxConstraints(maxWidth: 818),
            child: FractionallySizedBox(
              heightFactor: MediaQuery.of(context).size.width < 818 ? 0.4 : 0.8,
              child: PageView.builder(
                itemCount: albums['covers'].length,
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
                itemBuilder: (context, index) {
                  appName = albums['title'][index];
                  return GestureDetector(
                    onTap: () => Navigator.of(context)
                        .pushNamed(albums['routes'][index]),
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage('${albums['covers'][index]}'),
                              fit: MediaQuery.of(context).size.width < 818
                                  ? BoxFit.cover
                                  : BoxFit.contain,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            child: Text(
              '$appName',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            child: Text(
              'Scroll ->',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
