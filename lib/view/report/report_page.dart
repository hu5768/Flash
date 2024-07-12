import 'package:flash/Colors/color_group.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorGroup.BGC,
      appBar: AppBar(
        surfaceTintColor: ColorGroup.BGC, //스크롤시 바뀌는 색
        backgroundColor: ColorGroup.appbarBGC,
        title: const Text('영상 업로드하기'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: context.width * 0.8,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 212, 212, 212),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text("hu8232@naver.com 보내라\n이름이랑 한줄평까지 써라"),
            ),
          ),
        ],
      ),
    );
  }
}
