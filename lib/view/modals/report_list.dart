import 'package:flash/controller/dio/user_block_controller.dart';
import 'package:flutter/material.dart';

class ReportList extends StatelessWidget {
  final int solutionId;
  final String content;
  ReportList({super.key, required this.solutionId, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '이 컨텐츠를 신고하는 이유',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Text(
                '지식재산권 침해를 신고하는 경우를 제외하고 회원님의 신고는 익명으로 처리됩니다. ',
                style: TextStyle(fontSize: 12.0),
              ),
            ),
            Divider(),
            ReportCard(
              reson: '마음에 들지 않습니다.',
              solutionId: solutionId,
              content: content,
            ),
            ReportCard(
              reson: '스팸',
              solutionId: solutionId,
              content: content,
            ),
            ReportCard(
              reson: '나체 이미지 또는 성적 행위',
              solutionId: solutionId,
              content: content,
            ),
            ReportCard(
              reson: '사기 또는 거짓',
              solutionId: solutionId,
              content: content,
            ),
            ReportCard(
              reson: '마음에 들지 않습니다.',
              solutionId: solutionId,
              content: content,
            ),
            ReportCard(
              reson: '혐오 발언 또는 상징',
              solutionId: solutionId,
              content: content,
            ),
            ReportCard(
              reson: '다른 문제의 영상입니다',
              solutionId: solutionId,
              content: content,
            ),
          ],
        ),
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  ReportCard({
    super.key,
    required this.solutionId,
    required this.reson,
    required this.content,
  });

  final UserBlockController userBlockController = UserBlockController();
  final int solutionId;
  final String reson, content;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white, // 버튼 텍스트 색상
        padding: EdgeInsets.all(16.0),
        elevation: 0, // 그림자 효과 제거
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // 직사각형으로 설정
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
        // 신고 처리 로직
        userBlockController.report(solutionId, reson, content);
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          reson,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
