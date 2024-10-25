import 'package:flash/controller/dio/problem_list_controller.dart';
import 'package:flash/controller/problem_sort_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SortMenuButton extends StatelessWidget {
  final ProblemSortController problemTitleController = Get.find();
  final ProblemListController problemListController = Get.find();
  void _showSortMenu(BuildContext context, Offset offset) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    await showMenu(
      context: context,
      color: Colors.white,
      position: RelativeRect.fromRect(
        Rect.fromLTWH(offset.dx, offset.dy, 0, 0),
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem(
          onTap: () {
            SortClick('추천순', 'recommand');
          },
          child: Text("추천순"),
        ),
        PopupMenuItem(
          onTap: () {
            SortClick('인기순', 'views');
          },
          child: Text("인기순"),
        ),
        PopupMenuItem(
          onTap: () {
            SortClick('난이도순', 'difficulty');
          },
          child: Text("난이도순"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        Offset offset = renderBox.localToGlobal(Offset.zero);
        _showSortMenu(context, offset);
      },
      child: Obx(
        () {
          return Row(
            children: [
              Text(
                problemTitleController.sorttitle.value,
                style: TextStyle(fontSize: 14),
              ),
              Icon(Icons.keyboard_arrow_down),
            ],
          );
        },
      ),
    );
  }

  Future<void> SortClick(String title, String sortKey) async {
    AnalyticsService.buttonClick(
      'SortModal',
      '정렬기준_$sortKey',
      '',
      '',
    );
    problemTitleController.changeText(sortKey, title);
    await problemListController.FilterApply();
  }
}
