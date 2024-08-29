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

  var nickEmpty = true.obs;
  var instaEmpty = true.obs;
  var heightEmpty = true.obs;
  var reachEmpty = true.obs;
  var genderEmpty = true.obs;
  var profileEmpty = true.obs;

  @override
  void onInit() {
    super.onInit();
    nicknameText.addListener(() {
      nickEmpty.value = nicknameText.text.isEmpty;
    });
    instaridText.addListener(() {
      instaEmpty.value = instaridText.text.isEmpty;
    });
    heightText.addListener(() {
      heightEmpty.value = heightText.text.isEmpty;
    });
    reachText.addListener(() {
      reachEmpty.value = reachText.text.isEmpty;
    });
    selectedGender.listen((value) {
      genderEmpty.value = value.isEmpty;
    });
  }

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

  void backPage(BuildContext context) {
    if (onboardIndex.value > 0) {
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.pop(context);
    }
  }

  void onPageChanged(int index) {
    onboardIndex.value = index;
  }

  void updateOnboardInfo() {
    mypageController.updateMemberInfo(
      nicknameText.text,
      instaridText.text,
      double.tryParse(heightText.text) ?? 0,
      double.tryParse(reachText.text) ?? 0,
      selectedGender.value,
      "https://example.com/profile.jpg",
    );
  }
}
