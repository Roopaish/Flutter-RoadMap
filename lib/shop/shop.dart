import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/products_overview_screen.dart';
import 'screens/auth_screen.dart';
import 'providers/auth.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (ctx, auth, _) =>
          auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
    );
  }
}
