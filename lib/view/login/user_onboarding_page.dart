import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/user_onboarding_controlle.dart';
import 'package:flash/view/login/user_onboarding/gender_field.dart';
import 'package:flash/view/login/user_onboarding/height_field.dart';
import 'package:flash/view/login/user_onboarding/instarid_field.dart';
import 'package:flash/view/login/user_onboarding/nickname_field.dart';
import 'package:flash/view/login/user_onboarding/profile_field.dart';
import 'package:flash/view/login/user_onboarding/reach_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserOnboardingPage extends StatefulWidget {
  const UserOnboardingPage({super.key});

  @override
  State<UserOnboardingPage> createState() => _UserOnboardingPageState();
}

class _UserOnboardingPageState extends State<UserOnboardingPage> {
  final userOnboardingControlle = Get.put(UserOnboardingControlle());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorGroup.BGC,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorGroup.appbarBGC,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                userOnboardingControlle.backPage(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            Text(
              '회원정보 입력',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(33, 33, 33, 1),
              ),
            ),
            Row(
              children: [
                Obx(
                  () => Text(
                    (userOnboardingControlle.onboardIndex.value + 1).toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(33, 33, 33, 1),
                    ),
                  ),
                ),
                Text(
                  ' / 6',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(204, 204, 204, 1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: PageView(
        controller: userOnboardingControlle.pageController,
        onPageChanged: userOnboardingControlle.onPageChanged,
        physics: NeverScrollableScrollPhysics(),
        children: [
          NicknameField(),
          InstaridField(),
          HeightField(),
          ReachField(),
          GenderField(),
          ProfileField(),
        ],
      ),
    );
  }
}
