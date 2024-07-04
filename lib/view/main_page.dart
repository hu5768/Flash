import 'package:flash/controller/center_title_controller.dart';
import 'package:flash/technology_test/carousell_test.dart';
import 'package:flash/view/centers/center_list_page.dart';
import 'package:flash/view/problem/problem_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final centerTitleController = Get.put(CenterTitleController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Container(
          height: AppBar().preferredSize.height,
          decoration: const BoxDecoration(),
          child: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CenterListPage(),
                    allowSnapshotting: true,
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                    () => Text(
                      centerTitleController.centerTitle.toString(),
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ),
      ),
      body: const ProblemList(),
      //body: CarousellTest(),
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
