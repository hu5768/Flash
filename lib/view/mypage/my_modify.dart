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

class MyModify extends StatelessWidget {
  MyModify({super.key});
  final mypageModifyController = Get.put(MypageModifyController());
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
        automaticallyImplyLeading: false,
        title: Container(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    AnalyticsService.buttonClick(
                      'userModify',
                      '뒤로가기',
                      '',
                      '',
                    );
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                Text(
                  '내 정보 수정',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(33, 33, 33, 1),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (buttonDisable) return;
                    buttonDisable = true;
                    AnalyticsService.buttonClick(
                      'userModify',
                      '완료',
                      '',
                      '',
                    );
                    if (mypageModifyController.profileEmpty == true) {
                      //프로필 변함 x
                      await mypageModifyController.updateMemberInfoNoprofile(
                        mypageController.userModel.profileImageUrl!,
                      );
                    } else {
                      await mypageModifyController.updateMemberInfo();
                    }
                    await mypageController.fetchMemberData(); //mypage 갱신
                    Navigator.pop(context);
                  },
                  child: Text('완료', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: ColorGroup.appbarBGC,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Obx(
            () {
              final imageFile = mypageModifyController.selectedImage.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 160,
                    width: 160,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: mypageModifyController.profileEmpty ==
                              false
                          ? FileImage(imageFile!) as ImageProvider<Object>
                          : mypageModifyController
                                      .rxUserModel.profileImageUrl.value !=
                                  ''
                              ? NetworkImage(
                                  mypageController.userModel.profileImageUrl!,
                                )
                              : AssetImage(
                                  'assets/images/profile.png',
                                ), // 기본 이미지
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      AnalyticsService.buttonClick(
                        'userModify',
                        '프로필변경',
                        '',
                        '',
                      );
                      await mypageModifyController.pickImage();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      foregroundColor: Color.fromRGBO(83, 83, 83, 1),
                      backgroundColor: Color.fromRGBO(245, 245, 245, 1),

                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ), // 패딩
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24), // 모서리 둥글기
                      ),
                    ),
                    child: Text(
                      '프로필 이미지 변경',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(245, 245, 245, 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        ModifyInfoCard(
                          info: '닉네임',
                          infoValue:
                              mypageModifyController.rxUserModel.nickName.value,
                          child: ModifyNickname(),
                        ),
                        Divider(
                          height: 0,
                          color: Color.fromRGBO(233, 233, 233, 20),
                        ),
                        ModifyInfoCard(
                          info: '인스타그램 ID',
                          infoValue: mypageModifyController
                              .rxUserModel.instagramId.value,
                          child: ModifyInstargramid(),
                        ),
                        Divider(
                          height: 0,
                          color: Color.fromRGBO(233, 233, 233, 20),
                        ),
                        ModifyInfoCard(
                          info: '성별',
                          infoValue:
                              mypageModifyController.rxUserModel.gender.value ==
                                      ''
                                  ? '--'
                                  : mypageModifyController
                                              .rxUserModel.gender.value ==
                                          'MALE'
                                      ? '남성'
                                      : '여성',
                          child: ModifyGender(),
                        ),
                        Divider(
                          height: 0,
                          color: Color.fromRGBO(233, 233, 233, 20),
                        ),
                        ModifyInfoCard(
                          info: '키',
                          infoValue: mypageModifyController
                                      .rxUserModel.height.value ==
                                  0
                              ? '--'
                              : mypageModifyController.rxUserModel.height.value
                                  .toString(),
                          child: ModifyHegiht(),
                        ),
                        Divider(
                          height: 0,
                          color: Color.fromRGBO(233, 233, 233, 20),
                        ),
                        ModifyInfoCard(
                          info: '리치',
                          infoValue: mypageModifyController
                                      .rxUserModel.reach.value ==
                                  0
                              ? '--'
                              : mypageModifyController.rxUserModel.reach.value
                                  .toString(),
                          child: ModifyReach(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
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
                                  actionsPadding:
                                      EdgeInsets.fromLTRB(0, 0, 30, 10),
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
                                          (route) =>
                                              false, // 스택에 있는 모든 이전 라우트를 제거
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
                                  actionsPadding:
                                      EdgeInsets.fromLTRB(0, 0, 30, 10),
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
                                          mypageController.userModel.nickName ??
                                              '',
                                          mypageController
                                                  .userModel.instagramId ??
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
                                          (route) =>
                                              false, // 스택에 있는 모든 이전 라우트를 제거
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
              );
            },
          ),
        ),
      ),
    );
  }
}

class ModifyInfoCard extends StatelessWidget {
  ModifyInfoCard({
    super.key,
    required this.info,
    required this.infoValue,
    required this.child,
  });
  final String info, infoValue;
  final Widget child;
  final mypageModifyController = Get.put(MypageModifyController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        AnalyticsService.buttonClick(
          'userModify',
          info,
          '',
          '',
        );
        mypageModifyController.modifyText.text = '';
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => child,
          ),
        );
        //내 정보 다시 가져오기
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
                color: Color.fromRGBO(33, 33, 33, 1),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  infoValue,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(102, 102, 102, 1),
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
              ],
            ),
          ],
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
