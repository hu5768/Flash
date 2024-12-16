import 'package:flash/const/Colors/make_hold_color.dart';
import 'package:flash/controller/dio/first_answer_controller.dart';
import 'package:flash/controller/dio/problem_list_controller.dart';
import 'package:flash/controller/problem_sort_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class NextHoldModal extends StatelessWidget {
  final firstAnswerController = Get.put(FirstAnswerController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(14, 9, 14, 9), // 패딩 설정
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: const Color.fromARGB(255, 196, 196, 196), // 테두리 색상
        ),
        borderRadius: BorderRadius.circular(12.0), // 둥근 모서리
      ),
      child: Obx(
        () {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              firstAnswerController.selectHoldColor.value == ''
                  ? SvgPicture.asset(
                      'assets/images/empty_hold.svg',
                    )
                  : SvgPicture.string(
                      makeHold(firstAnswerController.selectHoldColor.value),
                    ),
              SizedBox(width: 10),
              Icon(
                Icons.keyboard_arrow_down,
                size: 32,
                color: firstAnswerController.selectHoldColor.value == ''
                    ? const Color.fromARGB(255, 17, 17, 17)
                    : const Color.fromARGB(255, 196, 196, 196),
              ),
            ],
          );
        },
      ),
    );
  }
}
