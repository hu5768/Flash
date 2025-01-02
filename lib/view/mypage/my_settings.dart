import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/const/data.dart';
import 'package:flash/controller/dio/login_controller.dart';
import 'package:flash/controller/dio/mypage_modify_controller.dart';
import 'package:flash/controller/dio/user_delete_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/login/login_page.dart';
import 'package:flash/view/mypage/user_info/modify_gender.dart';
import 'package:flash/view/mypage/user_info/modify_hegiht.dart';
import 'package:flash/view/mypage/user_info/modify_instargramid.dart';
import 'package:flash/view/mypage/user_info/modify_nickname.dart';
import 'package:flash/view/mypage/user_info/modify_reach.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';

import '../../controller/dio/mypage_controller.dart';

class MySettings extends StatelessWidget {
  MySettings({super.key});

  final mypageController = Get.put(MypageController());
  final userDeleteController = Get.put(UserDeleteController());
  final loginController = Get.put(LoginController());
  bool buttonDisable = false;
  @override
  Widget build(BuildContext context) {
    AnalyticsService.screenView('MyModifyPage', '');
    return Scaffold(
      backgroundColor: ColorGroup.BGC,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Container(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    AnalyticsService.buttonClick(
                      'mySettings',
                      '뒤로가기',
                      '',
                      '',
                    );
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                Text(
                  '설정',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(33, 33, 33, 1),
                  ),
                ),
                SizedBox(width: 50),
              ],
            ),
          ),
        ),
        backgroundColor: ColorGroup.appbarBGC,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(245, 245, 245, 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ModifyMemberCard(
                      clikFunction: loginController.OpenPI,
                      info: '개인정보처리방침',
                      textColor: Color.fromRGBO(33, 33, 33, 1),
                    ),
                    Divider(
                      height: 0,
                      color: Color.fromRGBO(233, 233, 233, 20),
                    ),
                    ModifyMemberCard(
                      clikFunction: loginController.OpenTU,
                      info: '이용약관',
                      textColor: Color.fromRGBO(33, 33, 33, 1),
                    ),
                    Divider(
                      height: 0,
                      color: Color.fromRGBO(233, 233, 233, 20),
                    ),
                    ModifyMemberCard(
                      info: '로그아웃',
                      textColor: Color.fromRGBO(33, 33, 33, 1),
                      clikFunction: () {
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
                              title: Text('로그아웃'),
                              content: Text('로그아웃 하시겠습니까?'),
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
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    '로그아웃',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: ColorGroup.selectBtnBGC,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  onPressed: () async {
                                    await storage.delete(
                                      key: ACCESS_TOKEN_KEY,
                                    );
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage(),
                                      ),
                                      (route) => false, // 스택에 있는 모든 이전 라우트를 제거
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    Divider(
                      height: 0,
                      color: Color.fromRGBO(233, 233, 233, 20),
                    ),
                    ModifyMemberCard(
                      info: '계정탈퇴',
                      textColor: Color.fromRGBO(255, 0, 0, 1),
                      clikFunction: () {
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
                              title: Text('계정 삭제'),
                              content: Text(
                                '업로드한 모든 영상이 사라집니다\n정말 계정을 삭제하시겠습니까?',
                              ),
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
                                      'userDelete',
                                      mypageController.userModel.nickName ?? '',
                                      mypageController.userModel.instagramId ??
                                          '',
                                      '',
                                    );
                                    userDeleteController.DeleteMember();
                                    await storage.delete(
                                      key: ACCESS_TOKEN_KEY,
                                    );
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage(),
                                      ),
                                      (route) => false, // 스택에 있는 모든 이전 라우트를 제거
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class ModifyMemberCard extends StatelessWidget {
  final mypageController = Get.put(MypageController());
  ModifyMemberCard({
    super.key,
    required this.info,
    required this.textColor,
    required this.clikFunction,
  });
  final String info;
  final Color textColor;
  final Function clikFunction;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        AnalyticsService.buttonClick(
          'userModifyMember',
          info,
          mypageController.userModel.instagramId ?? '',
          mypageController.userModel.nickName ?? '',
        );
        clikFunction();
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              info,
              style: TextStyle(
                fontSize: 17,
                color: textColor,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
