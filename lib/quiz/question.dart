import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String qsnText;

  Question(this.qsnText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // takes full width of screen
      margin: EdgeInsets.all(10),
      child: Text(
        qsnText,
        style: TextStyle(
          fontSize: 28,
          color: Colors.blue[900],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
