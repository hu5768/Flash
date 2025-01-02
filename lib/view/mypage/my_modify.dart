import 'dart:io';

import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/const/data.dart';
import 'package:flash/const/date_form.dart';
import 'package:flash/controller/dio/login_controller.dart';
import 'package:flash/controller/dio/mypage_modify_controller.dart';
import 'package:flash/controller/dio/user_delete_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/login/login_page.dart';
import 'package:flash/view/mypage/modify_toggle.dart';
import 'package:flash/view/mypage/user_info/modify_gender.dart';
import 'package:flash/view/mypage/user_info/modify_hegiht.dart';
import 'package:flash/view/mypage/user_info/modify_instargramid.dart';
import 'package:flash/view/mypage/user_info/modify_nickname.dart';
import 'package:flash/view/mypage/user_info/modify_reach.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';

import '../../controller/dio/mypage_controller.dart';

class MyModify extends StatelessWidget {
  MyModify({super.key});
  final mypageModifyController = Get.put(MypageModifyController());
  final mypageController = Get.put(MypageController());
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
                  '프로필 편집',
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
                    await mypageController.fetchMemberData(context); //mypage 갱신
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
        padding: EdgeInsets.all(24.0),
        child: Center(
          child: Obx(
            () {
              final imageFile = mypageModifyController.selectedImage.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ModifyToggle(),
                  SizedBox(height: 58),
                  mypageModifyController.toggleIndex.value == 0
                      ? MypageInfoModify(
                          imageFile: imageFile,
                        )
                      : AchievementsModify(),
                  SizedBox(height: 24),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class AchievementsModify extends StatelessWidget {
  AchievementsModify({
    super.key,
  });
  final mypageModifyController = Get.put(MypageModifyController());
  @override
  Widget build(BuildContext context) {
    return Column(
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
                    mypageModifyController.rxUserModel.profileImageUrl.value !=
                            ''
                        ? NetworkImage(
                            mypageModifyController
                                .rxUserModel.profileImageUrl.value,
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
                  mypageModifyController.rxUserModel.nickName.string ?? " ",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                //SizedBox(height: 4),
                Text(
                  '@' + mypageModifyController.rxUserModel.instagramId.string,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            if (mypageModifyController.rxUserModel.gender.value != '')
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 238, 238, 238),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  mypageModifyController.rxUserModel.gender.value == 'MALE'
                      ? Icons.male
                      : Icons.female_outlined,
                  color: const Color.fromARGB(255, 17, 17, 17),
                ),
              ),
            SizedBox(width: 4),
            if (mypageModifyController.rxUserModel.height.value != 0)
              Container(
                height: 32,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 238, 238, 238),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/icon/height_icon.svg',
                      colorFilter: ColorFilter.mode(
                        Color.fromARGB(255, 17, 17, 17),
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      formatDouble(
                        mypageModifyController.rxUserModel.height.value,
                      ).toString(),
                      style: TextStyle(
                        color: const Color.fromARGB(255, 17, 17, 17),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(width: 4),
            if (mypageModifyController.rxUserModel.reach.value != 0)
              Container(
                height: 32,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 238, 238, 238),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/icon/width_icon.svg',
                      colorFilter: ColorFilter.mode(
                        Color.fromARGB(255, 17, 17, 17),
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      formatDouble(
                        mypageModifyController.rxUserModel.reach.value,
                      ).toString(),
                      style: TextStyle(
                        color: const Color.fromARGB(255, 17, 17, 17),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        SizedBox(height: 8.0),
      ],
    );
  }
}

class MypageInfoModify extends StatelessWidget {
  MypageInfoModify({
    super.key,
    required this.imageFile,
  });

  final mypageModifyController = Get.put(MypageModifyController());
  final mypageController = Get.put(MypageController());
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 68,
          width: 68,
          child: CircleAvatar(
            radius: 60,
            backgroundImage: mypageModifyController.profileEmpty == false
                ? FileImage(imageFile!) as ImageProvider<Object>
                : mypageModifyController.rxUserModel.profileImageUrl.value != ''
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
                infoValue: mypageModifyController.rxUserModel.nickName.value,
                child: ModifyNickname(),
              ),
              Divider(
                height: 0,
                color: Color.fromRGBO(233, 233, 233, 20),
              ),
              ModifyInfoCard(
                info: '인스타그램 ID',
                infoValue: mypageModifyController.rxUserModel.instagramId.value,
                child: ModifyInstargramid(),
              ),
              Divider(
                height: 0,
                color: Color.fromRGBO(233, 233, 233, 20),
              ),
              ModifyInfoCard(
                info: '성별',
                infoValue: mypageModifyController.rxUserModel.gender.value == ''
                    ? '--'
                    : mypageModifyController.rxUserModel.gender.value == 'MALE'
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
                infoValue: mypageModifyController.rxUserModel.height.value == 0
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
                infoValue: mypageModifyController.rxUserModel.reach.value == 0
                    ? '--'
                    : mypageModifyController.rxUserModel.reach.value.toString(),
                child: ModifyReach(),
              ),
            ],
          ),
        ),
      ],
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
