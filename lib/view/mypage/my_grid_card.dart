import 'package:flash/const/Colors/center_color.dart';
import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/date_form.dart';
import 'package:flash/controller/dio/my_solution_detail_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/mypage/my_solution.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyVideoCard extends StatelessWidget {
  final int solutionId;
  final mySolutionDetailController = Get.put(MySolutionDetailController());
  final String gymName,
      sectorName,
      difficultyName,
      problemImageUrl,
      uploadedAt,
      profileUrl;
  MyVideoCard({
    super.key,
    required this.solutionId,
    required this.gymName,
    required this.sectorName,
    required this.difficultyName,
    required this.problemImageUrl,
    required this.uploadedAt,
    required this.profileUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        AnalyticsService.buttonClick(
          'MySolutionClick',
          solutionId.toString(),
          gymName,
          difficultyName,
        );
        await mySolutionDetailController.fetchData(solutionId);
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MySolution(
              solutionId: solutionId,
              profileUrl: profileUrl,
            ),
          ),
        );
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(problemImageUrl),
            fit: BoxFit.cover, // 이미지를 화면에 맞게 조정
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.9),
                const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
                const Color.fromARGB(0, 0, 0, 0),
              ],
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$gymName $sectorName',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                formatDateString(uploadedAt) + '업로드',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromRGBO(255, 255, 255, 0.8),
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 8),
              Row(
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
                            color:
                                CenterColor.TheClimbColorList[difficultyName],
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white, // 테두리 색상
                              width: 1,
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          difficultyName,
                          style: TextStyle(color: ColorGroup.btnBGC),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.0),
                  true
                      ? Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            Icons.play_circle_fill,
                            color: Colors.white,
                            size: 24.0,
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
