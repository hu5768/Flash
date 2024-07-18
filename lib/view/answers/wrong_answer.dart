import 'package:flutter/material.dart';

class WrongAnswer extends StatelessWidget {
  const WrongAnswer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 150),
          const Icon(Icons.signal_cellular_no_sim_outlined),
          const Text('만료된 문제입니다.'),
          const SizedBox(height: 60),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('홈으로 돌아가기')),
        ],
      ),
    );
  }
}
