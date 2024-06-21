import 'dart:math';

import 'package:flash/view/centers/center_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        /*bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.blue,
            height: 4.0, // 원하는 테두리의 높이
          ),
        ),*/
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Container(
          height: AppBar().preferredSize.height,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromARGB(255, 0, 0, 0),
                width: 2.0,
              ),
            ),
          ),
          child: const Center(
            child: Text(
              "Flash",
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
      body: CenterListPage(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text(
          '제보하기',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
