import 'package:dio/dio.dart';
import 'package:flash/const/data.dart';
import 'package:flash/controller/dio/achievements_controller.dart';
import 'package:flash/controller/dio/problem_list_controller.dart';
import 'package:flash/model/user_model.dart';
import 'package:flash/view/login/login_page.dart';
import 'package:flutter/material.dart';
import 'dio_singletone.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dios;

class MypageController extends GetxController {
  final problemListController = Get.put(ProblemListController());
  final achievementsController = Get.put(AchievementsController());
  var userModel = UserModel(
    nickName: '',
    instagramId: '',
    height: 1,
    reach: 1,
    gender: '',
    profileImageUrl: '',
  );
  String nickSafetyCode = '';

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> nickNameOverlap(String nickName) async {
    dios.Response response;
    final token = await storage.read(key: ACCESS_TOKEN_KEY);
    DioClient().updateOptions(token: token.toString());
    bool isAvailable = false;
    try {
      print('닉네임 중복확인 get');
      response = await DioClient().dio.get(
        "/members/nickname",
        data: {
          "nickName": nickName,
        },
      );

      Map<String, dynamic> resMap = Map<String, dynamic>.from(response.data);
      isAvailable = resMap["isAvailable"];
      nickSafetyCode = '이미 사용중인 닉네임입니다';
    } catch (e) {
      isAvailable = false;
      if (e is DioException) {
        if (e.response != null) {
          print('DioError: ${e.response?.statusCode}');
          print('Error Response Data: ${e.response?.data}');
          nickSafetyCode = e.response?.data['nickName'] ?? '';
        } else {
          print('Error: ${e.message}');
        }
      }
      print('아이디 중복 실패$e');
    }
    return isAvailable;
  }

  Future<void> fetchMemberData(context) async {
    achievementsController.fetchData();
    //유저 정보 받아오기
    dios.Response response;
    final token = await storage.read(key: ACCESS_TOKEN_KEY);
    DioClient().updateOptions(token: token.toString());
    try {
      print('유저 정보 get');
      response = await DioClient().dio.get(
            "/members",
          );

      Map<String, dynamic> resMap = Map<String, dynamic>.from(response.data);
      userModel = UserModel.fromJson(resMap);
      problemListController.userNickname = userModel.nickName ?? '';
    } catch (e) {
      print('유저 정보 받아오기 실패${e}');
      print('일단 에러나면 나가게');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (route) => false, // 스택에 있는 모든 이전 라우트를 제거
      );
      if (e is DioException) {
        if (e.response != null) {
          print('DioError: ${e.response?.statusCode}');
          print('Error Response Data: ${e.response}');
          if (e.response?.statusCode == 401) {
            print('마이페이지 나가기');
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false, // 스택에 있는 모든 이전 라우트를 제거
            );
          }
        }
      }
    }
  }

  Future<void> updateMemberInfo(
    String nickName,
    String instagramId,
    double height,
    double reach,
    String gender,
    String profileImg,
  ) async {
    final data = {
      "nickName": nickName,
      "instagramId": instagramId == '' ? null : instagramId,
      "height": height == 0 ? null : height,
      "gender": gender == '' ? null : gender,
      "reach": reach == 0 ? null : reach,
      "profileImageUrl": profileImg == '' ? null : profileImg,
    };

    try {
      // PATCH 요청
      print('유저 정보 Patch');
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
