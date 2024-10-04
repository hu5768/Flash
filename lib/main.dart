import 'package:flash/view/login.dart';
import 'package:flash/view/main_page.dart';
import 'package:flutter/material.dart';

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

      home: LoginPage(),
      //home: MainPage(),
    );
  }
}
