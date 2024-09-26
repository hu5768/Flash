import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/dio/problem_list_controller.dart';
import 'package:flash/controller/problem_sort_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SortModal extends StatelessWidget {
  const SortModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: ColorGroup.modalBGC,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 50,
              ),
              const Text(
                "문제 정렬 선택",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          SortOrder(title: '추천순', sortKey: 'recommand'),
          SortOrder(title: '인기순', sortKey: 'views'),
          SortOrder(title: '난이도순', sortKey: 'difficulty'),
        ],
      ),
    );
  }
}

class SortOrder extends StatelessWidget {
  final ProblemSortController problemTitleController = Get.find();
  final ProblemListController problemListController = Get.find();
  final String title, sortKey;
  SortOrder({
    super.key,
    required this.title,
    required this.sortKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: problemTitleController.sortkey.toString() == sortKey
                    ? TextStyle(fontSize: 18, color: ColorGroup.selectBtnBGC)
                    : TextStyle(fontSize: 18),
              ),
              problemTitleController.sortkey.toString() == sortKey
                  ? const Icon(Icons.check, color: ColorGroup.selectBtnBGC)
                  : const SizedBox(
                      width: 18,
                    ),
            ],
          ),
          onTap: () async {
            AnalyticsService.buttonClick(
              'SortModal',
              '정렬기준_$sortKey',
              '',
              '',
            );
            problemTitleController.changeText(sortKey, title);
            await problemListController.newFetch();
            problemListController.ScrollUp();
            Navigator.of(context).pop();
          },
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
