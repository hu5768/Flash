import 'package:flash/const/Colors/center_color.dart';
import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/date_form.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/answers/answers_carousell_page.dart';
import 'package:flutter/material.dart';

class ProblemCard extends StatelessWidget {
  final String gymName,
      id,
      sector,
      difficulty,
      settingDate,
      removalDate,
      imageUrl;
  final int solutionCount;
  final bool hasSolution, isHoney;

  const ProblemCard({
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
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AnalyticsService.problemClick(
          id,
          difficulty,
          sector,
          hasSolution.toString(),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnswersCarousell(
              gymName: gymName,
              id: id,
              hasSolution: hasSolution,
              difficulty: difficulty,
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
                        solutionCount.toString(),
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
