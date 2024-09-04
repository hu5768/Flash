import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/user_onboarding_controlle.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NicknameField extends StatelessWidget {
  NicknameField({super.key});
  final userOnboardingControlle = Get.put(UserOnboardingControlle());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣ]'),
                  ), // 영어 대소문자, 숫자, 한글만 허용
                  LengthLimitingTextInputFormatter(20),
                ],
                controller: userOnboardingControlle.nicknameText,
                style: TextStyle(fontSize: 24),
                maxLines: null,
                decoration: InputDecoration(
                  hintText: '닉네임을 입력해주세요',
                  hintStyle: TextStyle(fontSize: 24),
                  border: InputBorder.none,
                ),
                onChanged: (value) {},
              ),
              Obx(
                () {
                  return userOnboardingControlle.nickSafe.value
                      ? SizedBox()
                      : Text(
                          userOnboardingControlle.nickSafetyCode.value,
                          style:
                              TextStyle(color: Color.fromRGBO(255, 40, 0, 1)),
                        );
                },
              ),
            ],
          ),
          Obx(
            () {
              return Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: userOnboardingControlle.nickEmpty.value
                        ? ElevatedButton(
                            onPressed: () {
                              AnalyticsService.buttonClick(
                                'UserOnboarding',
                                '회색다음버튼',
                                '',
                                userOnboardingControlle.onboardIndex.value
                                    .toString(),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(250, 60),
                              foregroundColor: ColorGroup.selectBtnFGC,
                              backgroundColor: Color.fromRGBO(213, 213, 213, 1),
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
                          )
                        : ElevatedButton(
                            onPressed: () {
                              AnalyticsService.buttonClick(
                                'UserOnboarding',
                                '다음버튼',
                                '',
                                userOnboardingControlle.onboardIndex.value
                                    .toString(),
                              );
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
              );
            },
          ),
        ],
      ),
    );
  }
}
