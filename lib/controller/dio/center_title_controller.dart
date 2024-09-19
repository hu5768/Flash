import 'package:dio/dio.dart';
import 'package:flash/const/data.dart';
import 'package:flash/view/login/login_page.dart';
import 'package:flash/view/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dios;
import 'dio_singletone.dart';
import '../problem_filter_controller.dart';

class CenterTitleController extends GetxController {
  var centerId = 1.obs;
  var centerTitle = ''.obs;
  String mapImgUrl = '';
  List<String> gradeDifficulties = [];
  List<String> secterList = [];
  dynamic mainContext;
  @override
  void onInit() {
    super.onInit();
    centerId.value = 1;
    getTitle();
  }

  void getContext(context) {
    mainContext = context;
  }

  void changeId(int newId) {
    centerId.value = newId;
  }

  void getTitle() async {
    dios.Response response;
    try {
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());
      response = await DioClient().dio.get("/gyms/${centerId.value}");
      print(response.statusCode);
      Map<String, dynamic> resMap = Map<String, dynamic>.from(response.data);

      centerTitle.value = resMap['gymName'];
      mapImgUrl = resMap['mapImageUrl'];

      ProblemFilterController problemFilterController = Get.find();

      gradeDifficulties = List<String>.from(resMap['difficulties']);

      problemFilterController.gradeOption = gradeDifficulties;

      secterList = List<String>.from(resMap['sectors']);
      problemFilterController.sectorOption = secterList;

      problemFilterController.allInit();
    } catch (e) {
      print('암장 리스트 실패$e');
      //await storage.delete(key: ACCESS_TOKEN_KEY);
      /*Navigator.pushAndRemoveUntil(
        mainContext,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (route) => false, // 스택에 있는 모든 이전 라우트를 제거
      );
      centerTitle.value = '--';*/
    }
  }
}
