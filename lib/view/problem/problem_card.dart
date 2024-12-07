import 'package:flash/const/Colors/center_color.dart';
import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/const/Colors/make_hold_color.dart';
import 'package:flash/controller/date_form.dart';
import 'package:flash/controller/dio/answer_data_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/answers/answers_carousell_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProblemCard extends StatelessWidget {
  final String gymName,
      id,
      sector,
      difficulty,
      settingDate,
      removalDate,
      imageUrl,
      holdColorCode;
  final int solutionCount;
  final bool hasSolution, isHoney;
  final answerDataController = Get.put(AnswerDataController());
  ProblemCard({
    super.key,
    required this.gymName,
    required this.id,
    required this.sector,
    required this.difficulty,
    required this.settingDate,
    required this.removalDate,
    required this.hasSolution,
    required this.imageUrl,
    required this.isHoney,
    required this.solutionCount,
    required this.holdColorCode,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        AnalyticsService.problemClick(
          id,
          difficulty,
          sector,
          hasSolution.toString(),
        );
        await answerDataController.fetchData(id);
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnswersCarousell(
              gymName: gymName,
              id: id,
              hasSolution: hasSolution,
              difficulty: difficulty,
              sector: sector,
              holdColorCode: holdColorCode,
            ),
            allowSnapshotting: true,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
        decoration: BoxDecoration(
          color: ColorGroup.cardBGC,
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/problem.png',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            if (isHoney)
              Positioned(
                top: 20,
                left: 20,
                child: Container(
                  height: 37,
                  width: 77,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 204, 0), // 배경색
                    borderRadius: BorderRadius.circular(20), // 모서리 둥글게 (반지름 설정)
                  ),
                  child: Center(
                    child: Text(
                      '꿀이에요!',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                //color: Colors.black.withOpacity(0.1),
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
                    Row(
                      children: [
                        Container(
                          width: 62,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(0, 0, 0, 0)
                                .withOpacity(0.1),
                            //borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 10,
                                top: 5,
                                child: Container(
                                  width: 52,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: CenterColor
                                        .TheClimbColorList[difficulty],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: SvgPicture.string(
                                  makeHold(holdColorCode),
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "$sector Sector",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      formatDateString(settingDate) + ' 세팅',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (hasSolution)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.video_library,
                        color: Colors.white,
                        size: 24,
                      ),
                      Text(
                        ' ' + solutionCount.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
