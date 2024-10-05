import 'dart:math';

import 'package:flash/controller/login_controller.dart';
import 'package:flash/view/main_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  LoginController loginController = LoginController();
  final TextEditingController textController = TextEditingController(
    text:
        "ya29.a0AcM612xwWf8AVqPctg12yOFWe1B-vX79OGN8XYEFG-46JV_wXNJq5XTOkiGkfvHCitLcdzotyl9oW39Ze-ENXwkL3e1ItfK3QLrbkwgf1VUC6pNpZQyyc7A8IHKFsTxWlKQhu9MslZ_cpyMGmIEL4t0rLvOM0esREvvoQiddaCgYKARMSARMSFQHGX2MifDQ_e65lCPTbra6zJiozPQ0175",
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(200, 100, 200, 0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                loginController.googleSignIn();
              },
              child: const Text('구글로그인'),
            ),
            const SizedBox(
              height: 100,
            ),
            TextField(
              controller: textController, // 텍스트 필드와 컨트롤러 연결
              decoration: const InputDecoration(
                filled: true, // 배경을 채움
                fillColor: Colors.white, // 배경색을 흰색으로 설정
                border: OutlineInputBorder(), // 테두리 스타일
                hintText: '텍스트를 입력하세요', // 힌트 텍스트
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                bool loginS =
                    await loginController.TokenLogin(textController.text);
                print(LoginController.accessstoken);
                print(loginS);
                if (loginS) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  );
                }
              },
              child: const Text('토큰으로 이동'),
            ),
          ],
        ),
      ),
    );
  }
}
