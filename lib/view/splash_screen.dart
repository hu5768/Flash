import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/const/data.dart';
import 'package:flash/controller/dio/center_title_controller.dart';
import 'package:flash/controller/dio/problem_list_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/login/login_page.dart';
import 'package:flash/view/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String playStorUrl =
      "https://play.google.com/store/apps/details?id=com.climbing.flash";
  final String appStoreUrl = "https://apps.apple.com/us/app/flash/id6590617249";
  final centerTitleController = Get.put(CenterTitleController());
  final problemListController = Get.put(ProblemListController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _showUpdateDialog(context);
      checkToken();
    });
  }

  Future<void> OpenPlaystore() async {
    //이용약관
    if (await canLaunchUrl(Uri.parse(playStorUrl))) {
      await launchUrl(Uri.parse(playStorUrl));
    } else {
      throw 'Could not launch $playStorUrl';
    }
  }

  Future<void> OpenAppstore() async {
    //이용약관
    if (await canLaunchUrl(Uri.parse(appStoreUrl))) {
      await launchUrl(Uri.parse(appStoreUrl));
    } else {
      throw 'Could not launch $appStoreUrl';
    }
  }

  Future<void> _showUpdateDialog(BuildContext context) async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    print(packageInfo);
    print("ver : ${packageInfo.version}");
    print("bundle : ${packageInfo.buildNumber}");
    if (false) return;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('업데이트 필요'),
          content: Text('새로운 버전이 출시되었습니다. 최신 버전으로 업데이트해주세요.'),
          actions: <Widget>[
            TextButton(
              child: Text('나중에'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('업데이트'),
              onPressed: () {
                OpenAppstore();
                Navigator.of(context).pop(); // 팝업 닫기
              },
            ),
          ],
        );
      },
    );
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
