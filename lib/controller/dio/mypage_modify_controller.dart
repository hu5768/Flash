import 'dart:io';
import 'package:flash/const/uploadBaseUrl.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flash/const/data.dart';
import 'package:flash/controller/dio/mypage_controller.dart';
import 'package:flash/model/rx_user_model.dart';
import 'package:flash/model/user_model.dart';
import 'package:flutter/material.dart';
import 'dio_singletone.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dios;

class MypageModifyController extends GetxController {
  final mypageController = Get.put(MypageController());

  final TextEditingController modifyText = TextEditingController();
  var toggleIndex = 0.obs;
  var genderTmp = ''.obs;
  RXUserModel rxUserModel = RXUserModel(
    nickName: '',
    instagramId: '',
    height: 1,
    reach: 1,
    profileImageUrl: '',
    gender: 'MALE',
  );
  var isEmpty = true.obs;

  //nickname safety
  var nickSafe = true.obs;
  var nickSafetyCode = ''.obs;

  var selectedImage = Rxn<File>();
  var profileEmpty = true.obs;
  @override
  void onInit() {
    super.onInit();
    modifyText.addListener(() {
      // 텍스트가 비어 있으면 true, 아니면 false
      isEmpty.value = modifyText.text.isEmpty;
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

  void fetchMemberData() {
    modifyText.text = '';
    selectedImage.value = null;
    rxUserModel.nickName.value = mypageController.userModel.nickName!;
    rxUserModel.instagramId.value = mypageController.userModel.instagramId!;
    rxUserModel.height.value = mypageController.userModel.height!;
    rxUserModel.reach.value = mypageController.userModel.reach!;
    rxUserModel.profileImageUrl.value =
        mypageController.userModel.profileImageUrl!;
    rxUserModel.gender.value = mypageController.userModel.gender!;
  }

  Future<void> updateMemberInfoNoprofile(String profileImageUrl) async {
    final data = {
      "nickName": rxUserModel.nickName.value,
      "instagramId": rxUserModel.instagramId.value == ''
          ? null
          : rxUserModel.instagramId.value,
      "height": rxUserModel.height.value == 0 ? null : rxUserModel.height.value,
      "gender":
          rxUserModel.gender.value == '' ? null : rxUserModel.gender.value,
      "reach": rxUserModel.reach.value == 0 ? null : rxUserModel.reach.value,
      "profileImageUrl": profileImageUrl,
    };

    try {
      // PATCH 요청
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());
      final response = await DioClient().dio.patch('/members', data: data);

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
          print('Error: ${e.message}');
        }
      }
    }
  }

  Future<void> updateMemberInfo() async {
    String fileName = '';
    if (selectedImage.value != null)
      fileName = basename(selectedImage.value!.path);
    dios.FormData data = dios.FormData.fromMap({
      "file": selectedImage.value == null
          ? null
          : await dios.MultipartFile.fromFile(
              selectedImage.value!.path,
              filename: fileName,
            ),
    });
    for (var file in data.files) {
      print("File: ${file.key}: ${file.value.filename}");
    }
    try {
      // PATCH 요청
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());
      final response =
          await DioClient().dio.post('${uploadServerUrl}images/', data: data);

      if (response.statusCode == 200) {
        // 요청이 성공적으로 처리된 경우
        print('Member information updated successfully');
        final String profileImageUrl = response.data["profileImageUrl"];

        await updateMemberInfoNoprofile(profileImageUrl);
      } else {
        print('Failed to update member information: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('DioError: ${e.response?.statusCode}');
          print('Error Response Data: ${e.response?.data}');
        } else {
          print('Error: ${e.message}');
        }
      }
    }
  }
}
