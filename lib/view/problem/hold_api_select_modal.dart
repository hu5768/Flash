import 'package:flash/const/make_hold.dart';
import 'package:flash/controller/dio_singletone.dart';
import 'package:flash/controller/first_answer_controller.dart';
import 'package:flash/controller/login_controller.dart';
import 'package:flash/controller/problem_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HoldApiSelectModal extends StatelessWidget {
  final firstAnswerController = Get.put(FirstAnswerController());
  final ProblemListController problemListController = Get.find();
  String thisProblemId;
  Future<void> holdReset(
    String problemId,
    int holdId,
  ) async {
    DioClient().updateOptions(token: LoginController.accessstoken);
    final response = await DioClient().dio.patch(
      '/admin/problems/$problemId/holds',
      data: {'holdId': holdId},
    );
    problemListController.newFetch();
  }

  HoldApiSelectModal({super.key, required this.thisProblemId});
  void _showMenu(BuildContext context, Offset offset) async {
    await showDialog(
      context: context,
      barrierColor: Colors.transparent, // 배경 클릭 감지
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              right: MediaQuery.of(context).size.width * 0.7 -
                  offset.dx, //오른쪽 부터 계산
              top: offset.dy - MediaQuery.of(context).size.width * 0.3,
              child: Container(
                padding: const EdgeInsets.all(24),
                width: MediaQuery.of(context).size.width * 0.3, // 메뉴의 전체 너비
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
                      onTap: () async {
                        await holdReset(
                          thisProblemId,
                          firstAnswerController.Holdid[index],
                        );
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
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('홀드색'),
            SizedBox(width: 10),
            Icon(
              Icons.keyboard_arrow_down,
              size: 32,
              color: Color.fromARGB(255, 17, 17, 17),
            ),
          ],
        ),
      ),
    );
  }
}
