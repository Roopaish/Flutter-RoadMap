import 'package:flutter/material.dart';

import 'answer.dart';
import 'question.dart';

class QuizPanel extends StatelessWidget {
  final List<Map<String, Object>> qsns;
  final int qsnIndex;
  final Function ansQsn;

  QuizPanel({
    required this.qsns,
    required this.ansQsn,
    required this.qsnIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Question(
          qsns[qsnIndex]['qsn'] as String,
        ),
        ...(qsns[qsnIndex]['ans'] as List<Map<String, Object>>).map((ans) {
          return Answer(() => ansQsn(ans['score']), ans['text'] as String);
        }).toList()
      ],
    );
  }
}
