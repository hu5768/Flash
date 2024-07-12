import 'package:flash/technology_test/video_test.dart';
import 'package:flash/view/answers/answers_carousell_page.dart';
import 'package:flash/view/main_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      //home: AnswersCarousell(sector: '2'),
    );
  }
}
