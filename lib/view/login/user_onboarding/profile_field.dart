import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/user_onboarding_controlle.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileField extends StatelessWidget {
  ProfileField({super.key});
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
            children: [
              SizedBox(
                height: 160,
                width: 160,
                child: Obx(
                  () {
                    final imageFile =
                        userOnboardingControlle.selectedImage.value;

                    return CircleAvatar(
                      radius: 60,
                      backgroundImage: imageFile != null
                          ? FileImage(imageFile) as ImageProvider<Object>
                          : AssetImage('assets/images/profile.png'), // 기본 이미지
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              Obx(
                () {
                  final imageFile = userOnboardingControlle.selectedImage.value;
                  return ElevatedButton(
                    onPressed: () {
                      userOnboardingControlle.pickImage();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      foregroundColor: imageFile != null
                          ? Color.fromRGBO(83, 83, 83, 1)
                          : Color.fromRGBO(0, 87, 255, 1),
                      backgroundColor: imageFile != null
                          ? Color.fromRGBO(234, 234, 234, 1)
                          : Color.fromRGBO(217, 230, 255, 1),

                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ), // 패딩
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24), // 모서리 둥글기
                      ),
                    ),
                    child: imageFile != null
                        ? Text(
                            '프로필 이미지 변경',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            '프로필 이미지 선택',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  );
                },
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () async {
                    AnalyticsService.buttonClick(
                      'UserOnboarding',
                      '건너뛰기',
                      '',
                      userOnboardingControlle.onboardIndex.value.toString(),
                    );
                    //프로필 이미지 초기화
                    await userOnboardingControlle.updateOnboardInfo();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                      (route) => false, // 스택에 있는 모든 이전 라우트를 제거
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(250, 60),
                    backgroundColor: ColorGroup.selectBtnFGC,
                    foregroundColor: const Color.fromRGBO(83, 83, 83, 1),
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "프로필 이미지 없이 시작하기",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
              Obx(
                () {
                  return SizedBox(
                    width: double.infinity,
                    child: userOnboardingControlle.profileEmpty.value
                        ? ElevatedButton(
                            onPressed: () {
                              AnalyticsService.buttonClick(
                                'UserOnboarding',
                                '회색 다음버튼',
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
                            onPressed: () async {
                              AnalyticsService.buttonClick(
                                'UserOnboarding',
                                '다음버튼',
                                '',
                                userOnboardingControlle.onboardIndex.value
                                    .toString(),
                              );
                              //서버에 데이터 전송하는 버튼

                              await userOnboardingControlle
                                  .updateOnboardInfoProfile();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainPage(),
                                ),
                                (route) => false, // 스택에 있는 모든 이전 라우트를 제거
                              );
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
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
