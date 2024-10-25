import 'package:flash/const/Colors/center_color.dart';
import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/date_form.dart';
import 'package:flash/controller/dio/answer_data_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/animations/blink_animation.dart';
import 'package:flash/view/upload/answer_upload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProblemDetailCard extends StatelessWidget {
  final answerDataController = Get.put(AnswerDataController());
  final String problemId,
      gymName,
      sector,
      difficulty,
      settingDate,
      removalDate,
      imgUrl,
      imageSource,
      guide;
  final bool hasSolution, isHoney;
  ProblemDetailCard({
    super.key,
    required this.problemId,
    required this.gymName,
    required this.sector,
    required this.difficulty,
    required this.settingDate,
    required this.removalDate,
    required this.imgUrl,
    required this.hasSolution,
    required this.imageSource,
    required this.guide,
    required this.isHoney,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(
              imgUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/problem.jpeg', //오류 이미지
                  fit: BoxFit.fitHeight,
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 93),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: CenterColor.TheClimbColorList[difficulty],
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white, // 테두리 색상
                              width: 1,
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          difficulty,
                          style: TextStyle(color: ColorGroup.btnBGC),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "$gymName $sector Sector",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formatDateString(settingDate) +
                                ' 세팅 - ' +
                                formatDateString(removalDate) +
                                ' 탈거',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            '문제사진 제공: @$imageSource',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 8.0),
                      if (hasSolution)
                        Row(
                          children: [
                            Icon(
                              Icons.video_library,
                              color: Colors.white,
                              size: 24,
                            ),
                            Obx(
                              () {
                                return Text(
                                  ' ' +
                                      answerDataController.solutionCount.value
                                          .toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                );
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          guide == 'NULL'
              ? SizedBox()
              : Align(
                  alignment: Alignment.center,
                  child: BlinkAnimation(),
                ),
        ],
      ),
    );
  }
}
