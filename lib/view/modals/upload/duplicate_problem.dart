import 'package:flutter/material.dart';

class DuplicateProblem extends StatelessWidget {
  const DuplicateProblem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [Text('동일한 문제의 답지가 있는 것 같습니다. 해당 답지에 추가로 업로드 할까요?')],
      ),
    );
  }
}
