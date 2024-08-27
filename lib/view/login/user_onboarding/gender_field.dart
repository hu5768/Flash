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
      padding: const EdgeInsets.all(20),
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
                        userOnboardingControlle.selectedGender.value == '남성'
                            ? Colors.blue.shade100
                            : Colors.grey.shade100,
                    textColor:
                        userOnboardingControlle.selectedGender.value == '남성'
                            ? Colors.blue
                            : Colors.grey,
                    trailing:
                        userOnboardingControlle.selectedGender.value == '남성'
                            ? Icon(Icons.check, color: Colors.blue)
                            : null,
                    onTap: () =>
                        userOnboardingControlle.selectedGender.value = '남성',
                  ),
                  SizedBox(height: 8),
                  ListTile(
                    leading: Icon(Icons.female),
                    title: Text('여성입니다'),
                    tileColor:
                        userOnboardingControlle.selectedGender.value == '여성'
                            ? Colors.blue.shade100
                            : Colors.grey.shade100,
                    textColor:
                        userOnboardingControlle.selectedGender.value == '여성'
                            ? Colors.blue
                            : Colors.grey,
                    trailing:
                        userOnboardingControlle.selectedGender.value == '여성'
                            ? Icon(Icons.check, color: Colors.blue)
                            : null,
                    onTap: () =>
                        userOnboardingControlle.selectedGender.value = '여성',
                  ),
                ],
              );
            },
          ),
          Column(
            children: [
              SizedBox(
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
              ),
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
    );
  }
}
