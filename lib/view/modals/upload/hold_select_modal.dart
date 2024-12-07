import 'package:flash/const/Colors/make_hold_color.dart';
import 'package:flash/controller/dio/first_answer_controller.dart';
import 'package:flash/controller/dio/problem_list_controller.dart';
import 'package:flash/controller/problem_sort_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HoldSelectModal extends StatelessWidget {
  final firstAnswerController = Get.put(FirstAnswerController());
  void _showMenu(BuildContext context, Offset offset) async {
    await showDialog(
      context: context,
      barrierColor: Colors.transparent, // 배경 클릭 감지
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              right: MediaQuery.of(context).size.width - offset.dx, //오른쪽 부터 계산
              top: offset.dy + 8,
              child: Container(
                padding: const EdgeInsets.all(24),
                width: MediaQuery.of(context).size.width * 0.7, // 메뉴의 전체 너비
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
                child: GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true, // 크기 자동 조정
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                  children: List.generate(
                      firstAnswerController.HoldOption.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        firstAnswerController.selectHoldColor.value =
                            firstAnswerController.HoldOption[index];
                        firstAnswerController.selectHoldId =
                            firstAnswerController.Holdid[index];
                        firstAnswerController.requiredCheck();
                        Navigator.pop(context);
                      },
                      child: SvgPicture.string(
                        makeHold(firstAnswerController.HoldOption[index]),
                        width: 40,
                        height: 40,
                      ),
                    );
                  }),
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
        padding: EdgeInsets.fromLTRB(14, 9, 14, 9),
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
            renderBox.size.width,
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
      ),
    );
  }
}
