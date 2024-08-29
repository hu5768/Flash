import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/user_onboarding_controlle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HeightField extends StatelessWidget {
  HeightField({super.key});
  final userOnboardingControlle = Get.put(UserOnboardingControlle());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}\.?\d{0,1}')),
            ],
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            controller: userOnboardingControlle.heightText,
            style: TextStyle(fontSize: 24),
            maxLines: null,
            decoration: InputDecoration(
              suffixText: 'cm',
              suffixStyle: TextStyle(
                  fontSize: 24, color: Color.fromRGBO(153, 153, 153, 1)),
              hintText: '키를 입력해주세요',
              hintStyle: TextStyle(fontSize: 24),
              border: InputBorder.none,
            ),
            onChanged: (value) {},
          ),
          Obx(
            () {
              return Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        userOnboardingControlle.heightText.text = '';
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
                    child: userOnboardingControlle.heightEmpty.value
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
