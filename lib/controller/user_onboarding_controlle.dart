import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flash/const/data.dart';
import 'package:flash/controller/dio/dio_singletone.dart';
import 'package:flash/controller/dio/mypage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as gets;

class UserOnboardingControlle extends gets.GetxController {
  final mypageController = gets.Get.put(MypageController());
  var onboardIndex = 0.obs;
  int maxIndex = 6;
  final pageController = PageController();

  final TextEditingController nicknameText = TextEditingController();
  final TextEditingController instaridText = TextEditingController();
  final TextEditingController heightText = TextEditingController();
  final TextEditingController reachText = TextEditingController();
  var selectedGender = ''.obs;
  var selectedImage = gets.Rxn<File>();

  var nickEmpty = true.obs;
  var instaEmpty = true.obs;
  var heightEmpty = true.obs;
  var reachEmpty = true.obs;
  var genderEmpty = true.obs;
  var profileEmpty = true.obs;

  var nickSafe = true.obs;
  var nickSafetyCode = ''.obs;
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
    selectedImage.listen((image) {
      profileEmpty.value = image == null;
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

  void nextPage() async {
    if (onboardIndex.value == 0) {
      bool isSafe = await mypageController.nickNameOverlap(nicknameText.text);
      nickSafe.value = isSafe;
      if (isSafe) {
        pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      } else {
        nickSafetyCode.value = mypageController.nickSafetyCode;
      }
    } else if (onboardIndex.value < maxIndex) {
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
      "",
    );
    onboardIndex.value = 0;
  }

  Future<void> updateOnboardInfoProfile() async {
    String fileName = basename(selectedImage.value!.path);
    FormData data = FormData.fromMap({
      "nickName": nicknameText.text,
      "instagramId": instaridText.text == '' ? null : instaridText.text,
      "height": double.tryParse(heightText.text) == 0
          ? null
          : double.tryParse(heightText.text),
      "gender": selectedGender.value == '' ? null : selectedGender.value,
      "reach": double.tryParse(reachText.text) == 0
          ? null
          : double.tryParse(reachText.text),
      "file": await MultipartFile.fromFile(
        selectedImage.value!.path,
        filename: fileName,
      ),
    });

    try {
      // PATCH 요청
      print('유저 정보 Patch');
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());
      final response = await DioClient()
          .dio
          .patch('https://upload.dev.climbing-answer.com/members/', data: data);

      if (response.statusCode == 200) {
        // 요청이 성공적으로 처리된 경우
        print('Member information updated successfully');
      } else {
        print('Failed to update member information: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('DioError: ${e.response?.statusCode}');
          print('Error Response Data: ${e.response?.data}');
        } else {
          print('Error: ${e.error}');
          print('Error: ${e.response}');
        }
      }
    }
    onboardIndex.value = 0;
  }
}
