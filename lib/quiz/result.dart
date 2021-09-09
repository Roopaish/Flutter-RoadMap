import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalScore;
  final Function resetHandler;

  Result(this.totalScore, this.resetHandler);

  String get resultPhrase {
    final percent = totalScore * 5;
    String resultText = "You scored $percent%. ";
    if (percent <= 50) {
      resultText += 'That was good!';
    } else if (percent <= 80) {
      resultText += "Pretty awesome!";
    } else {
      resultText += "You rock!";
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            resultPhrase.toUpperCase(),
            style: TextStyle(
              fontSize: 24,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40,
          ),
          TextButton(
            onPressed: () => resetHandler(),
            child: Text(
              'Restart Quiz',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.indigo[800]),
            ),
          ),
        ],
      ),
    );
  }
}
