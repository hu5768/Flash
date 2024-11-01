import 'dart:math';

import 'package:flash/controller/login_controller.dart';
import 'package:flash/view/main_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  LoginController loginController = LoginController();
  final TextEditingController textController = TextEditingController(
    text:
        "ya29.a0AcM612wb8b3LfddauBL1Gtem7_bpqALS-Rwub4kDXdKXF_7jK0V28YdOjVZn76JFHCwgrQdDlTRn5BQ6DP2xoY5WGH9cehkE3YQOEbcRspASXBdmyTCCg5n8dVooxdsN7BjlqS6MUc7Z8HNDfV0Uugzs5oCrDzx2ayIzaLAfaCgYKAZYSARMSFQHGX2MiiG4QZ1SAjb6KmkRP8w3E7Q0175",
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
