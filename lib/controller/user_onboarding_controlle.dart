import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flash/controller/dio/mypage_controller.dart';
import 'package:flash/view/login/user_onboarding/profile_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserOnboardingControlle extends GetxController {
  final mypageController = Get.put(MypageController());
  var onboardIndex = 0.obs;
  int maxIndex = 6;
  final pageController = PageController();

  final TextEditingController nicknameText = TextEditingController();
  final TextEditingController instaridText = TextEditingController();
  final TextEditingController heightText = TextEditingController();
  final TextEditingController reachText = TextEditingController();
  var selectedGender = ''.obs;
  var selectedImage = Rxn<File>();

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      selectedImage.value = File(result.files.single.path!);
    }
  }

  void nextPage() {
    if (onboardIndex.value < maxIndex) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {}
  }

  void backPage() {
    if (onboardIndex.value > 0) {
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Get.back();
    }
  }

  void onPageChanged(int index) {
    onboardIndex.value = index;
  }

  void updateOnboardInfo() {
    mypageController.updateMemberInfo(
      nicknameText.text,
      instaridText.text,
      double.tryParse(heightText.text)!,
      double.tryParse(reachText.text)!,
      selectedGender.value,
      "https://example.com/profile.jpg",
    );
  }
}
