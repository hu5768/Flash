import 'package:flash/const/Colors/center_color.dart';
import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/view/mypage/my_solution.dart';
import 'package:flutter/material.dart';

class MyVideoCard extends StatelessWidget {
  final String index, videoUrl;
  final String uploader, instagramId, review;
  const MyVideoCard({
    super.key,
    required this.index,
    required this.videoUrl,
    required this.uploader,
    required this.instagramId,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MySolution(
              uploader: uploader,
              instagramId: instagramId,
              review: review,
              videoUrl: videoUrl,
              solutionId: 1,
              problemId: '2',
              uploaderId: '2',
              isUploader: true,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background1.jpeg'),
            fit: BoxFit.cover, // 이미지를 화면에 맞게 조정
          ),
          borderRadius: BorderRadius.circular(16),
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
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '더클라임 강남 3&4',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '2024년 9월 $index일 세팅',
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
                          color: CenterColor.TheClimbColorList['파랑'],
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white, // 테두리 색상
                            width: 1,
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '파랑',
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
    );
  }
}
