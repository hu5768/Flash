import 'package:dio/dio.dart';
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
  var genderTmp = ''.obs;
  RXUserModel rxUserModel = RXUserModel(
    nickName: '',
    instagramId: '',
    height: 1,
    reach: 1,
    profileImageUrl: 'https://example.com/profile.jpg',
    gender: 'MALE',
  );
  var isEmpty = true.obs;
  @override
  void onInit() {
    super.onInit();
    modifyText.addListener(() {
      // 텍스트가 비어 있으면 true, 아니면 false
      isEmpty.value = modifyText.text.isEmpty;
    });
  }

  void fetchMemberData() {
    modifyText.text = '';
    rxUserModel.nickName.value = mypageController.userModel.nickName!;
    rxUserModel.instagramId.value = mypageController.userModel.instagramId!;
    rxUserModel.height.value = mypageController.userModel.height!;
    rxUserModel.reach.value = mypageController.userModel.reach!;
    rxUserModel.profileImageUrl.value =
        mypageController.userModel.profileImageUrl!;
    rxUserModel.gender.value = mypageController.userModel.gender!;
  }

  Future<void> updateMemberInfo() async {
    final data = {
      "nickName": rxUserModel.nickName.value,
      "instagramId": rxUserModel.instagramId.value,
      "height": rxUserModel.height.value,
      "gender": rxUserModel.gender.value,
      "reach": rxUserModel.reach.value,
      "profileImageUrl": "https://example.com/profile.jpg",
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
}
