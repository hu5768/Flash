import 'package:flash/const/Colors/center_color.dart';
import 'package:flash/controller/dio/first_answer_controller.dart';
import 'package:flash/controller/dio/problem_list_controller.dart';
import 'package:flash/controller/problem_sort_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class GradeSelectModal extends StatelessWidget {
  final firstAnswerController = Get.put(FirstAnswerController());
  void _showMenu(BuildContext context, Offset offset) async {
    await showDialog(
      context: context,
      barrierColor: Colors.transparent, // 배경 클릭 감지
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              left: MediaQuery.of(context).size.width * 0.15,
              top: offset.dy + 8,
              child: Container(
                padding: const EdgeInsets.all(20),
                height: 70,
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: firstAnswerController.gradeOption.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        firstAnswerController.selectGrade.value =
                            firstAnswerController.gradeOption[index];
                        firstAnswerController.requiredCheck();
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: CenterColor.TheClimbColorList[
                                firstAnswerController.gradeOption[index]],
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.fromLTRB(14, 14, 14, 14),
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
        AnalyticsService.buttonClick(
          'UploadButtonPage',
          '난이도선택',
          '',
          '',
        );
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        Offset offset = renderBox.localToGlobal(
          Offset(
            0,
            0,
          ),
        );
        _showMenu(context, offset);
      },
      child: Container(
        child: Obx(
          () {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                firstAnswerController.selectGrade.value == ''
                    ? SvgPicture.asset(
                        'assets/images/empty_color.svg',
                      )
                    : Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: CenterColor.TheClimbColorList[
                              firstAnswerController.selectGrade.value],
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                SizedBox(width: 10),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 32,
                  color: firstAnswerController.selectGrade.value == ''
                      ? const Color.fromARGB(255, 17, 17, 17)
                      : const Color.fromARGB(255, 196, 196, 196),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
