import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/user_onboarding_controlle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InstaridField extends StatelessWidget {
  InstaridField({super.key});

  final userOnboardingControlle = Get.put(UserOnboardingControlle());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextField(
            controller: userOnboardingControlle.instaridText,
            style: TextStyle(fontSize: 24),
            maxLines: null,
            decoration: InputDecoration(
              hintText: '인스타그램 id를 입력해주세요',
              hintStyle: TextStyle(fontSize: 24),
              border: InputBorder.none,
            ),
            onChanged: (value) {},
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
