import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function ansHandler;
  final String ansText;

  Answer(this.ansHandler, this.ansText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.purple,
          padding: EdgeInsets.symmetric(vertical: 20),
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        onPressed: () {
          ansHandler();
        },
        child: Text(ansText),
      ),
    );
  }
}
