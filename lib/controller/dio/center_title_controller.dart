import 'package:dio/dio.dart';
import 'package:flash/const/data.dart';
import 'package:flash/model/center_detail_model.dart';
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

  var centerDetailModel = CenterDetailModel().obs;
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

  Future<void> getTitle() async {
    dios.Response response;
    try {
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());
      response = await DioClient().dio.get("/gyms/${centerId.value}");

      Map<String, dynamic> resMap = Map<String, dynamic>.from(response.data);
      centerDetailModel.value = CenterDetailModel.fromJson(resMap);
      centerTitle.value = resMap['gymName'];
      ProblemFilterController problemFilterController = Get.find();
      problemFilterController.gradeOption =
          centerDetailModel.value.difficulties!;
      problemFilterController.sectorOption = centerDetailModel.value.sectors!;
      await problemFilterController.allInit();
    } catch (e) {
      print('암장 타이틀 실패$e');
      print(centerId.value);
      print(centerTitle.value);
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
