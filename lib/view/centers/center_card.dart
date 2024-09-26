import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/dio/center_title_controller.dart';
import 'package:flash/controller/dio/problem_list_controller.dart';
import 'package:flash/controller/problem_sort_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CenterCard extends StatelessWidget {
  final int id;
  final String title, thum;
  CenterCard({
    super.key,
    required this.id,
    required this.title,
    required this.thum,
  });
  final CenterTitleController centerTitleController = Get.find();
  final ProblemListController problemListController = Get.find();
  final ProblemSortController problemSortController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        AnalyticsService.buttonClick(
          'CenterModal',
          '센터선택_$title',
          '',
          '',
        );
        problemSortController.allInit();
        centerTitleController.changeId(id);
        await centerTitleController.getTitle();
        await problemListController.newFetch();
        problemListController.ScrollUp();
        Navigator.pop(context);
      },
      child: Container(
        height: 80,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipOval(
                  child: Image.network(
                    thum,
                    height: 55,
                    width: 55,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/problem.png',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20), //여기에 주소 추가
                  ],
                ),
              ],
            ),
            centerTitleController.centerId == id
                ? Icon(
                    Icons.check,
                    color: ColorGroup.selectBtnBGC,
                  )
                : SizedBox(width: 50),
          ],
        ),
      ),
    );
  }
}
