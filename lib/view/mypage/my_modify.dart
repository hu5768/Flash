import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/dio/mypage_modify_controller.dart';
import 'package:flash/view/mypage/user_info/modify_gender.dart';
import 'package:flash/view/mypage/user_info/modify_hegiht.dart';
import 'package:flash/view/mypage/user_info/modify_instargramid.dart';
import 'package:flash/view/mypage/user_info/modify_nickname.dart';
import 'package:flash/view/mypage/user_info/modify_reach.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/dio/mypage_controller.dart';

class MyModify extends StatelessWidget {
  MyModify({super.key});
  final mypageModifyController = Get.put(MypageModifyController());
  final mypageController = Get.put(MypageController());
  @override
  Widget build(BuildContext context) {
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
                    await mypageModifyController.updateMemberInfo();
                    await mypageController.fetchMemberData();
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 160,
                    width: 160,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          AssetImage('assets/images/flash.png'), // 기본 이미지
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
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
                              .rxUserModel.height.value
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
                              .rxUserModel.reach.value
                              .toString(),
                          child: ModifyReach(),
                        ),
                      ],
                    ),
                  ),
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
                          info: '로그아웃',
                          textColor: Color.fromRGBO(33, 33, 33, 1),
                          clikFunction: () {},
                        ),
                        Divider(
                          height: 0,
                          color: Color.fromRGBO(233, 233, 233, 20),
                        ),
                        ModifyMemberCard(
                          info: '계정탈퇴',
                          textColor: Color.fromRGBO(255, 0, 0, 1),
                          clikFunction: () {},
                        ),
                      ],
                    ),
                  ),
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
      onTap: () async {
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
      onTap: () {
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
