import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flash/firebase_options.dart';
import 'package:flash/technology_test/video_test.dart';
import 'package:flash/view/answers/answers_carousell_page.dart';
import 'package:flash/view/main_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/
  runApp(const App());
}

class App extends StatelessWidget {
  /*static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
*/
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      /*
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],*/
      home: MainPage(),
      //home: AnswersCarousell(sector: '2'),
    );
  }
}
