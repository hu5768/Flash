import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/user_onboarding_controlle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenderField extends StatelessWidget {
  GenderField({super.key});
  final userOnboardingControlle = Get.put(UserOnboardingControlle());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () {
              return Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.male),
                    title: Text('남성입니다'),
                    tileColor:
                        userOnboardingControlle.selectedGender.value == 'MALE'
                            ? Colors.blue.shade100
                            : Colors.grey.shade100,
                    textColor:
                        userOnboardingControlle.selectedGender.value == 'MALE'
                            ? Colors.blue
                            : Colors.grey,
                    trailing:
                        userOnboardingControlle.selectedGender.value == 'MALE'
                            ? Icon(Icons.check, color: Colors.blue)
                            : null,
                    onTap: () =>
                        userOnboardingControlle.selectedGender.value = 'MALE',
                  ),
                  SizedBox(height: 8),
                  ListTile(
                    leading: Icon(Icons.female),
                    title: Text('여성입니다'),
                    tileColor:
                        userOnboardingControlle.selectedGender.value == 'FEMALE'
                            ? Colors.blue.shade100
                            : Colors.grey.shade100,
                    textColor:
                        userOnboardingControlle.selectedGender.value == 'FEMALE'
                            ? Colors.blue
                            : Colors.grey,
                    trailing:
                        userOnboardingControlle.selectedGender.value == 'FEMALE'
                            ? Icon(Icons.check, color: Colors.blue)
                            : null,
                    onTap: () =>
                        userOnboardingControlle.selectedGender.value = 'FEMALE',
                  ),
                ],
              );
            },
          ),
          Obx(
            () {
              return Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        userOnboardingControlle.selectedGender.value = '';
                        userOnboardingControlle.nextPage();
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
                        "건너뛰기",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: userOnboardingControlle.genderEmpty.value
                        ? ElevatedButton(
                            onPressed: () {},
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
