import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flash/Colors/color_group.dart';
import 'package:flash/controller/center_title_controller.dart';
import 'package:flash/technology_test/carousell_test.dart';
import 'package:flash/technology_test/fake_api_pagination_test.dart';
import 'package:flash/view/centers/center_list_page.dart';
import 'package:flash/view/problem/problem_list.dart';
import 'package:flash/view/report/report_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  final FirebaseAnalytics analytics;
  MainPage({super.key, required this.analytics});
  final centerTitleController = Get.put(CenterTitleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorGroup.BGC,
      appBar: AppBar(
        surfaceTintColor: ColorGroup.BGC, //스크롤시 바뀌는 색
        backgroundColor: ColorGroup.appbarBGC,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() {
                        return Text(
                          centerTitleController.centerTitle.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        );
                      }),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('지도'),
                            content: const Text('안녕?'),
                            actions: [
                              TextButton(
                                child: const Text('안녕!'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.map),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: ProblemList(),
      //body: CarousellTest(),
      floatingActionButton: SizedBox(
        width: 100,
        height: 100,
        child: FloatingActionButton(
          foregroundColor: ColorGroup.selectBtnBGC,
          backgroundColor: ColorGroup.modalSBtnBGC,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(
              color: ColorGroup.selectBtnBGC,
              width: 1.5,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ReportPage(),
                allowSnapshotting: true,
              ),
            );
          },
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_upload_outlined,
                  size: 30,
                ),
                Text(
                  '업로드',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
