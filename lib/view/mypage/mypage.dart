import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/view/mypage/my_grid_view.dart';
import 'package:flutter/material.dart';

class Mypage extends StatelessWidget {
  Mypage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorGroup.BGC,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 68,
                        height: 68,
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundImage: NetworkImage(
                            'https://via.placeholder.com/150',
                          ), // 사용자 이미지 URL 사용
                        ),
                      ),
                      SizedBox(width: 12.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '서한유',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '@seo_hanyu',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          // 수정하기 버튼 눌렸을 때 실행될 코드
                        },
                        child: Text(
                          '수정하기',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: InfoCard(label: '성별', value: '남성', cm: false),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: InfoCard(label: '키', value: '177.8', cm: true),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: InfoCard(label: '리치', value: '183', cm: true),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MyGridView(),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String label;
  final String value;
  final bool cm;
  InfoCard({required this.label, required this.value, required this.cm});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              cm
                  ? Text(
                      ' cm',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(187, 187, 187, 1),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
