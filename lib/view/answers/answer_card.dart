import 'package:flash/technology_test/video_test.dart';
import 'package:flutter/material.dart';

class AnswerCard extends StatelessWidget {
  const AnswerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VideoTest(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '제보자 : 서한유!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '스타트에서 힘 꽉 주고 탑으로 뛰어서 탑홀드를 양손으로 잡고 버티면 됩니다',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
