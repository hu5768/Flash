import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flash/firebase_options.dart';
import 'package:flash/view/main_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flash',
      debugShowCheckedModeBanner: false,

      home: MainPage(),
      //home: MainPage(),
    );
  }
}
