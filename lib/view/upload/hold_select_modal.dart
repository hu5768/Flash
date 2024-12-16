import 'package:flash/const/make_hold.dart';
import 'package:flash/controller/first_answer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HoldSelectModal extends StatelessWidget {
  final firstAnswerController = Get.put(FirstAnswerController());

  HoldSelectModal({super.key});
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
                width: MediaQuery.of(context).size.width * 0.4, // 메뉴의 전체 너비
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
        padding: const EdgeInsets.fromLTRB(14, 9, 14, 9),
        side: const BorderSide(
          width: 1,
          color: Color.fromARGB(
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
                    ? const Text('홀드색')
                    : SvgPicture.string(
                        makeHold(firstAnswerController.selectHoldColor.value),
                      ),
                const SizedBox(width: 10),
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
