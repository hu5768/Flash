import 'package:dio/dio.dart';
import 'package:flash/const/data.dart';
import 'package:flash/const/gym_id.dart';
import 'package:flash/controller/dio/first_answer_controller.dart';
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
  var problemFilterController = Get.put(ProblemFilterController());
  var firstAnswerController = Get.put(FirstAnswerController());
  var centerDetailModel = CenterDetailModel().obs;
  dynamic mainContext;

  @override
  void onInit() async {
    super.onInit();
    final gymId = await firstStorage.read(key: GYM_ID) ?? '1';
    centerId.value = int.parse(gymId);

    getTitle();
  }

  void getContext(context) {
    mainContext = context;
  }

  Future<void> changeId(int newId) async {
    centerId.value = newId;
    firstStorage.write(key: GYM_ID, value: newId.toString());
  }

  Future<void> getTitle() async {
    dios.Response response;
    try {
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());
      response = await DioClient().dio.get("/gyms/${centerId.value}");
      Map<String, dynamic> resMap = Map<String, dynamic>.from(response.data);
      centerDetailModel.value = CenterDetailModel.fromJson(resMap);

      //gym이름
      centerTitle.value = centerDetailModel.value.gymName!;

      //난이도 리스트
      problemFilterController.gradeOption =
          centerDetailModel.value.difficulties!;
      firstAnswerController.gradeOption = centerDetailModel.value.difficulties!;

      //섹터 이름 리스트
      problemFilterController.sectorOption = centerDetailModel.value.sectors!
              .map((sector) => sector.name ?? '')
              .toList() ??
          [];
      firstAnswerController.sectorOption = centerDetailModel.value.sectors!
              .map((sector) => sector.name ?? '')
              .toList() ??
          [];

      //섹터 그래픽 리스트
      problemFilterController.sectorImageUrl = centerDetailModel.value.sectors!
              .map((sector) => sector.selectedImageUrl ?? '')
              .toList() ??
          [];
      firstAnswerController.sectorImageUrl = centerDetailModel.value.sectors!
              .map((sector) => sector.selectedImageUrl ?? '')
              .toList() ??
          [];

      //필터 초기화
      await problemFilterController.allInit();
    } catch (e) {
      print('암장 타이틀 실패$e');
      print(centerId.value);
      print(centerTitle.value);
    }
  }
}
