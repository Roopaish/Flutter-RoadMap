import 'package:flutter/material.dart';
import 'screens/products_overview_screen.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProductsOverviewScreen();
  }
}
