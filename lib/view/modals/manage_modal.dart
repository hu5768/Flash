import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/answer_carousel_controller.dart';
import 'package:flash/controller/dio/answer_data_controller.dart';
import 'package:flash/controller/dio/answer_modify_controller.dart';
import 'package:flash/controller/dio/my_gridview_controller.dart';
import 'package:flash/controller/dio/my_solution_detail_controller.dart';
import 'package:flash/controller/dio/solution_delete_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/upload/answer_modify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageModal extends StatelessWidget {
  ManageModal({
    super.key,
    required this.problemId,
    required this.solutionId,
    required this.videoUrl,
    required this.review,
  });
  final String problemId, videoUrl, review;
  final int solutionId;
  final answerCarouselController = Get.put(AnswerCarouselController());
  final myGridviewController = Get.put(MyGridviewController());
  final mySolutionDetailController = Get.put(MySolutionDetailController());
  final SolutionDeleteController solutionDeleteController =
      SolutionDeleteController();
  final answerDataController = Get.put(AnswerDataController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 8, 24, 50),
      decoration: BoxDecoration(
        color: Color.fromRGBO(247, 247, 247, 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color.fromARGB(213, 213, 213, 255),
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    AnalyticsService.buttonClick(
                      'solutionMore',
                      '수정',
                      '',
                      '',
                    );
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnswerModify(
                          problemId: '',
                          gymName: '',
                          videoUrl: videoUrl,
                          solutionId: solutionId,
                          review: review,
                        ),
                      ),
                    );
                    //answerCarouselController.cIndex.value = 0;
                    if (problemId != '') //문제 캐러샐에서 본 경우
                    {
                      print('index${answerCarouselController.cIndex.value}');
                      await answerDataController.fetchData(problemId);
                      print('index${answerCarouselController.cIndex.value}');
                      answerCarouselController.carouselSliderController
                          .jumpToPage(
                        answerCarouselController.cIndex.value,
                      );
                      print('index${answerCarouselController.cIndex.value}');

                      //,
                    } else {
                      // 마이페이지에서 본 경우
                      mySolutionDetailController.fetchData(solutionId);
                      //Navigator.of(context).pop();
                    }
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 22, 0, 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.edit, color: Colors.black),
                        SizedBox(width: 16),
                        Text(
                          '수정하기',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: Color.fromRGBO(246, 246, 246, 1),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    AnalyticsService.buttonClick(
                      'solutionMore',
                      '삭제',
                      '',
                      '',
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          actionsPadding: EdgeInsets.fromLTRB(0, 0, 30, 10),
                          backgroundColor: ColorGroup.BGC,
                          titleTextStyle: TextStyle(
                            fontSize: 15,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w700,
                          ),
                          contentTextStyle: TextStyle(
                            fontSize: 13,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          title: Text('게시물 삭제'),
                          content: Text('정말 게시물을 삭제하시겠습니까?'),
                          actions: [
                            TextButton(
                              child: Text(
                                '취소',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: ColorGroup.selectBtnBGC,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              onPressed: () {
                                AnalyticsService.buttonClick(
                                  'delete',
                                  '취소',
                                  '',
                                  '',
                                );
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text(
                                '삭제',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: ColorGroup.selectBtnBGC,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              onPressed: () async {
                                AnalyticsService.buttonClick(
                                  'delete',
                                  '진짜삭제',
                                  '',
                                  '',
                                );
                                await solutionDeleteController.DeleteSolution(
                                  solutionId,
                                );
                                await answerDataController.disposeVideo();
                                answerCarouselController.cIndex.value = 0;
                                if (problemId != '') //문제 캐러샐에서 본 경우
                                  answerDataController.fetchData(problemId);
                                else {
                                  // 마이페이지에서 본 경우
                                  await myGridviewController
                                      .fetchData(); //잘 안되는듯
                                  Navigator.of(context).pop();
                                }
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 22, 0, 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.delete, color: Colors.black),
                        SizedBox(width: 16),
                        Text(
                          '삭제하기',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
