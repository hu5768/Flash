import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/dio/my_gridview_controller.dart';
import 'package:flash/controller/dio/mypage_controller.dart';
import 'package:flash/controller/dio/mypage_modify_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/login/login_page.dart';
import 'package:flash/view/mypage/my_grid_view.dart';
import 'package:flash/view/mypage/my_modify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Mypage extends StatefulWidget {
  Mypage({super.key});

  @override
  State<Mypage> createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  final mypageModifyController = Get.put(MypageModifyController());
  final mypageController = Get.put(MypageController());
  MyGridviewController myGridviewController = Get.put(MyGridviewController());
  @override
  Widget build(BuildContext context) {
    AnalyticsService.screenView(
      'MyPage',
      mypageController.userModel.nickName ?? 'yet',
    );
    return Scaffold(
      backgroundColor: ColorGroup.BGC,
      body: SingleChildScrollView(
        controller: myGridviewController.scrollController,
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
                          backgroundImage:
                              mypageController.userModel.profileImageUrl != ''
                                  ? NetworkImage(
                                      mypageController
                                          .userModel.profileImageUrl!,
                                    )
                                  : AssetImage(
                                      'assets/images/profile.png',
                                    ), // 사용자 이미지 URL 사용
                        ),
                      ),
                      SizedBox(width: 12.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mypageController.userModel.nickName ?? " ",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          //SizedBox(height: 4),
                          Text(
                            '@' + mypageController.userModel.instagramId!,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () async {
                          AnalyticsService.buttonClick(
                            'MyPage',
                            '수정하기',
                            '',
                            '',
                          );
                          if (mypageController.userModel.nickName == null) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                              (route) => false, // 스택에 있는 모든 이전 라우트를 제거
                            );
                          } else {
                            mypageModifyController.fetchMemberData();
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyModify(),
                              ),
                            );
                            //내 정보 다시 가져오기
                            setState(() {});
                          }
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
                        child: InfoCard(
                          label: '성별',
                          value: mypageController.userModel.gender == ''
                              ? '--'
                              : mypageController.userModel.gender == 'MALE'
                                  ? '남성'
                                  : '여성',
                          cm: false,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: InfoCard(
                          label: '키',
                          value: mypageController.userModel.height == 0
                              ? '--'
                              : mypageController.userModel.height.toString(),
                          cm: true,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: InfoCard(
                          label: '리치',
                          value: mypageController.userModel.reach == 0
                              ? '--'
                              : mypageController.userModel.reach.toString(),
                          cm: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: Color.fromRGBO(245, 245, 245, 1),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MyGridView(
                profileUrl: mypageController.userModel.profileImageUrl ?? '',
              ),
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
        color: Color.fromRGBO(245, 245, 245, 1),
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
