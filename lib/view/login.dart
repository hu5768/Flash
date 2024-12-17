import 'dart:math';

import 'package:flash/controller/login_controller.dart';
import 'package:flash/view/main_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  LoginController loginController = LoginController();
  final TextEditingController textController = TextEditingController(
    text:
        "ya29.a0ARW5m756hkQqEjHTyPbKe-EMLfMenGa9m1t8V5iIusCsy1WTXB0KBpO1Ey_7dEANacoH9jSNFM9gVeJ1hSBRz51MBJvJ24yjeklTjtum4g7udeAQ319nDIEUgcALYPAZN7KrVb0X_0jgZZQNMZ4EY--S9MuguSWZl6eAoK21aCgYKAYESARMSFQHGX2Min5FwpJhAbYX5P7O1ZxESfQ0175",
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
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
              child: const Text('뒤로가기 실수로 눌렀을 때'),
            ),
          ],
        ),
      ),
    );
  }
}
