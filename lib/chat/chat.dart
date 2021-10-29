import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'screens/chat_screen.dart';
import 'screens/auth_screen.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    // return FutureBuilder(
    //   // Initialize FlutterFire:
    //   future: _initialization,
    //   builder: (context, appSnapshot) {
    return AuthScreen();
    // },
    // );
  }
}
