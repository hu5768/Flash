import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/user_onboarding_controlle.dart';
import 'package:flash/view/login/user_onboarding_detail.dart';
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
        backgroundColor: ColorGroup.appbarBGC,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                userOnboardingControlle.backPage();
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
                    userOnboardingControlle.onboardIndex.string,
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              onboardList[userOnboardingControlle.onboardIndex.value],
              Column(
                children: [
                  userOnboardingControlle.onboardIndex != 1
                      ? SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              userOnboardingControlle.nextPage();
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(250, 60),
                              backgroundColor: ColorGroup.selectBtnFGC,
                              foregroundColor: ColorGroup.selectBtnBGC,
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              "건너뛰기",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                  SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        userOnboardingControlle.nextPage();
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(250, 60),
                        foregroundColor: ColorGroup.selectBtnFGC,
                        backgroundColor: ColorGroup.selectBtnBGC,
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "다음",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
