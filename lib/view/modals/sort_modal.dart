import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/problem_list_controller.dart';
import 'package:flash/controller/problem_sort_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SortModal extends StatelessWidget {
  const SortModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorGroup.modalBGC,
      padding: const EdgeInsets.all(16.0),
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
                "문제 정렬",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ],
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
  //컨트롤러 자료형 없이 등록하면 어떻게 되는지 질문
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
        const Divider(),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              problemTitleController.sortkey.toString() == sortKey
                  ? const Icon(Icons.check, color: ColorGroup.selectBtnBGC)
                  : const SizedBox(
                      width: 20,
                    ),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          onTap: () {
            AnalyticsService.sendSortModalEvent(title);
            problemTitleController.changeText(sortKey, title);
            problemListController.newFetch();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
