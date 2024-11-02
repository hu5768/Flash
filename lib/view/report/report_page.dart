import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/login_controller.dart';
import 'package:flash/controller/sector_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportPage extends StatelessWidget {
  ReportPage({super.key});
  final String reportForm =
      '제목: [닉네임] 영상 제보합니다!\n영상\n(선택)인스타 계정:  \n(선택)한 줄 평: ex)\n1번 한줄평 : 탑 전 홀드를 잡고 왼발을 오른쪽으로 빼며 카운터 밸런스를 이용하면 쉽게 풀려요! \n3번 한줄평 : 보라치고 쉬워요';
  final String myEmail = 'flashclimbing3@gmail.com';
  var sectorController = Get.put(SectorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('바로가기'),
      ),
      backgroundColor: ColorGroup.BGC,
      body: Center(
        child: SizedBox(
          width: 600,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Clipboard.setData(
                    ClipboardData(text: LoginController.accessstoken),
                  );
                },
                child: const Text('엑세스 토큰 복사'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  Uri url = Uri.parse(
                    'https://d297x044mh9gdo.cloudfront.net/',
                  );
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw '이 URL을 열 수 없습니다: $url';
                  }
                },
                child: const Text('문제 업로드 사이트'),
              ),
              const SizedBox(height: 150),
              const Text(
                '섹터 생성',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: sectorController.gymCon,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'gym id',
                  fillColor: Colors.white, // 배경색을 흰색으로 설정
                  filled: true, // 배경색을 적용하도록 설정
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: sectorController.secCon,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '섹터명',
                  fillColor: Colors.white, // 배경색을 흰색으로 설정
                  filled: true, // 배경색을 적용하도록 설정
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: sectorController.adminCon,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'admin name',
                  fillColor: Colors.white, // 배경색을 흰색으로 설정
                  filled: true, // 배경색을 적용하도록 설정
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: sectorController.settingCon,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '세팅일',
                  fillColor: Colors.white, // 배경색을 흰색으로 설정
                  filled: true, // 배경색을 적용하도록 설정
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  sectorController.makeSector();
                },
                child: const Text('섹터 생성'),
              ),
              Obx(
                () {
                  return Text("sector id ${sectorController.sectorText.value}");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CopyButton extends StatelessWidget {
  final String copyText;
  const CopyButton({
    super.key,
    required this.copyText,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Clipboard.setData(ClipboardData(text: copyText));
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        fixedSize: const Size(90, 10),
        side: const BorderSide(
          color: ColorGroup.selectBtnBGC,
          width: 1.5,
        ),
        foregroundColor: ColorGroup.selectBtnBGC,
        backgroundColor: ColorGroup.modalSBtnBGC,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(0),
        child: Text('복사하기', style: TextStyle(fontSize: 14)),
      ),
    );
  }
}
