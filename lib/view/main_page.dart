import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/center_title_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/centers/center_list_page.dart';
import 'package:flash/view/problem/problem_list.dart';
import 'package:flash/view/report/report_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  MainPage({
    super.key,
  });
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
                AnalyticsService.sendMainButtonEvent(
                  'center_list_button',
                  centerTitleController.centerTitle.toString(),
                );
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
                        return const Text(
                          "centerTitleController.centerTitle",
                          style: TextStyle(fontWeight: FontWeight.w800),
                        );
                      }),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      AnalyticsService.sendMainButtonEvent(
                        'map_button',
                        centerTitleController.centerTitle.toString(),
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            contentPadding: const EdgeInsets.all(0),
                            backgroundColor: Colors.transparent,
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    AnalyticsService.sendMainButtonEvent(
                                      'close_map_button',
                                      centerTitleController.centerTitle
                                          .toString(),
                                    );
                                    Navigator.of(context).pop();
                                  },
                                ),
                                SizedBox(
                                  child: Image.network(
                                    width: 350,
                                    height: 350,
                                    centerTitleController.mapImgUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        width: 350,
                                        height: 350,
                                        'assets/images/problem.jpeg',
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
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
            AnalyticsService.sendMainButtonEvent(
              'upload_button',
              centerTitleController.centerTitle.toString(),
            );
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
