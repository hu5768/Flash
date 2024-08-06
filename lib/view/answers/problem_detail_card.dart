import 'package:flash/const/Colors/center_color.dart';
import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/date_form.dart';
import 'package:flutter/material.dart';

class ProblemDetailCard extends StatelessWidget {
  final String gymName, sector, difficulty, settingDate, removalDate, imgUrl;
  final bool hasSolution;
  const ProblemDetailCard({
    super.key,
    required this.gymName,
    required this.sector,
    required this.difficulty,
    required this.settingDate,
    required this.removalDate,
    required this.imgUrl,
    required this.hasSolution,
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
              fit: BoxFit.fitHeight,
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
              padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
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
                  Text(
                    "$gymName $sector",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    formatDateString(removalDate) +
                        ' 탈거ㆍ' +
                        formatDateString(settingDate) +
                        ' 세팅',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
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
                                    CenterColor.TheClimbColorList[difficulty],
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
                      SizedBox(width: 8.0),
                      hasSolution
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            backgroundColor: ColorGroup.modalBGC,
                            context: context,
                            builder: (BuildContext context) {
                              return Text('추후 추가될 기능입니다');
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          backgroundColor: Colors.grey.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          '내 풀이 업로드',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
