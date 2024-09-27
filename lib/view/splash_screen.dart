import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/const/data.dart';
import 'package:flash/controller/dio/center_title_controller.dart';
import 'package:flash/controller/dio/problem_list_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/login/login_page.dart';
import 'package:flash/view/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final centerTitleController = Get.put(CenterTitleController());
  final problemListController = Get.put(ProblemListController());
  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void checkToken() async {
    /*storage.write(
      key: ACCESS_TOKEN_KEY,
      value: "aaaaaaaaaaa",
    );*/
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    if (accessToken == null) {
      Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 300), // 애니메이션 지속 시간 설정
        ),
        (route) => false,
      );
    } else {
      //최초 회원 가입시 안불러와지는 버그 수정
      await centerTitleController.getTitle();
      await problemListController.newFetch();
      Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => MainPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 300), // 애니메이션 지속 시간 설정
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    AnalyticsService.screenView('SplashScreen', '');
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Image.asset('assets/images/flash.png'),
        ),
      ),
    );
  }
}
