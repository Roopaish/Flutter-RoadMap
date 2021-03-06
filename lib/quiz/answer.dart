import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function ansHandler;
  final String ansText;

  Answer(this.ansHandler, this.ansText);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 100, maxWidth: 300),
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blueGrey[200],
          onPrimary: Colors.blue[900],
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        onPressed: () {
          ansHandler();
        },
        child: Text(
          ansText,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
