import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flash/const/data.dart';
import 'package:flash/controller/dio/login_controller.dart';
import 'package:flash/firebase_options.dart';

import 'package:flash/view/login/login_page.dart';
import 'package:flash/view/login/user_onboarding_page.dart';
import 'package:flash/view/main_page.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flash/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final loginController = Get.put(LoginController());
  await loginController.initAccount();

  final appLinks = AppLinks(); // AppLinks is singleton

// Subscribe to all events (initial link and further)
  final sub = appLinks.uriLinkStream.listen((uri) {
    // Do something (navigation, ...)

    print("deep link : ${uri}");
  });

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runZonedGuarded(
    () {},
    (error, stack) => FirebaseCrashlytics.instance.recordError(
      error,
      stack,
      fatal: true,
    ),
  );
  debugPaintSizeEnabled = false;
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(const App());
}

class App extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flash',
      debugShowCheckedModeBanner: false,

      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics), //이름 같아도 되나
      ],

      //home: LoginPage(),
      //home: UserOnboardingPage(),
      home: SplashScreen(),
      // home: MainPage(),
    );
  }
}
