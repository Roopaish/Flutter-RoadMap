import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function ansHandler;

  Answer(this.ansHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        onPressed: () {
          ansHandler();
        },
        child: Text("ans 1"),
      ),
    );
  }
}
