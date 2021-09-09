import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalScore;

  Result(this.totalScore);

  String get resultPhrase {
    String resultText;
    if (totalScore <= 8) {
      resultText = 'You are ...strange?';
    } else if (totalScore <= 12) {
      resultText = "Pretty likable!";
    } else {
      resultText = "You're innocent!";
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        resultPhrase,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
