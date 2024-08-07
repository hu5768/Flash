import 'package:flash/controller/login_controller.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    //LoginController.initAccount();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 200, 50, 100),
            child: Center(
              child: Image.asset('assets/images/flash.png'),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                LoginButton(
                  logoImgUrl: 'assets/images/google_logo.png',
                  btnText: 'Google로 시작하기',
                  bgnColor: Color.fromRGBO(250, 250, 250, 0.2),
                  fgnColor: Colors.white,
                  onPressed: LoginController.googleSignIn,
                ),
                SizedBox(height: 16),
                LoginButton(
                  logoImgUrl: 'assets/images/kakao_logo.png',
                  btnText: '카카오로 시작하기',
                  bgnColor: Colors.yellow,
                  fgnColor: Colors.black,
                  onPressed: LoginController.googleSignOut,
                ),
                SizedBox(height: 16),
                LoginButton(
                  logoImgUrl: 'assets/images/apple_logo.png',
                  btnText: 'Apple로 시작하기',
                  bgnColor: Colors.white,
                  fgnColor: Colors.black,
                  onPressed: () {},
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 12),
                        Text(
                          ' 이용약관',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '  |  ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '개인정보 처리방침',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '문의하기 ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  String logoImgUrl, btnText;
  Color bgnColor, fgnColor;
  Function()? onPressed;
  LoginButton({
    super.key,
    required this.logoImgUrl,
    required this.btnText,
    required this.bgnColor,
    required this.fgnColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgnColor,
          minimumSize: Size(double.infinity, 70),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              logoImgUrl,
              scale: 2,
            ),
            Text(
              btnText,
              style: TextStyle(color: fgnColor, fontSize: 17),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
