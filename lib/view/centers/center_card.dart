import 'package:flash/controller/center_title_controller.dart';
import 'package:flash/controller/problem_list_controller.dart';
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
  final centerTitleController = Get.put(CenterTitleController());
  final ProblemListController problemListController = Get.find();
  final ProblemSortController problemSortController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AnalyticsService.sendCenterButtonEvent(title);
        problemSortController.allInit();
        centerTitleController.changeId(id);
        centerTitleController.getTitle();
        problemListController.newFetch();

        Navigator.pop(context);
      },
      child: Container(
        height: 80,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipOval(
              child: Image.network(
                thum,
                width: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/problem.jpeg',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              width: 70,
            ),
            const Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}
