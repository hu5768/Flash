import 'package:flash/controller/dio/first_answer_controller.dart';
import 'package:flash/controller/dio/problem_list_controller.dart';
import 'package:flash/controller/dio/upload_controller.dart';
import 'package:flash/controller/problem_sort_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class VoteSelectModal extends StatelessWidget {
  final firstAnswerController = Get.put(FirstAnswerController());
  void _showMenu(BuildContext context, Offset offset) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    await showMenu(
      context: context,
      color: Colors.white,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + 8,
        overlay.size.width - offset.dx + 112, // 오른쪽 공간
        0,
      ),
      items: [
        PopupMenuItem(
          onTap: () {
            firstAnswerController.difficultyLabel.value = '꿀이에요';
          },
          child: Text(
            "꿀이에요",
            style: TextStyle(fontSize: 16),
          ),
        ),
        PopupMenuItem(
          onTap: () {
            firstAnswerController.difficultyLabel.value = '보통이에요';
          },
          child: Text(
            "보통이에요",
            style: TextStyle(fontSize: 16),
          ),
        ),
        PopupMenuItem(
          onTap: () {
            firstAnswerController.difficultyLabel.value = '어려워요';
          },
          child: Text(
            "어려워요",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.fromLTRB(13, 14, 13, 14),
        side: BorderSide(
          width: 1,
          color: const Color.fromARGB(
            255,
            196,
            196,
            196,
          ),
        ),
        foregroundColor: const Color.fromARGB(255, 115, 115, 115),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      onPressed: () {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        Offset offset = renderBox.localToGlobal(
          Offset(
            0,
            renderBox.size.height,
          ),
        );
        _showMenu(context, offset);
      },
      child: Obx(
        () {
          return Container(
            height: 30,
            width: 112,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  firstAnswerController.difficultyLabel.value,
                  style: TextStyle(
                    fontSize: 16,
                    color: const Color.fromARGB(255, 1, 1, 1),
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> SortClick(String title, String sortKey) async {}
}
