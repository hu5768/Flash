import 'package:dio/dio.dart' as dios;
import 'package:dio/dio.dart';
import 'package:flash/const/data.dart';
import 'package:flash/controller/dio/center_title_controller.dart';
import 'package:flash/controller/dio/first_answer_controller.dart';
import 'package:flash/controller/problem_filter_controller.dart';
import 'package:flash/controller/problem_sort_controller.dart';
import 'package:flash/model/hold_color_model.dart';
import 'package:flash/model/problems_model.dart';
import 'package:flash/view/login/login_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dio_singletone.dart';

class HoldColorController extends GetxController {
  final firstAnswerController = Get.put(FirstAnswerController());

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getHolds() async {
    dios.Response response;

    try {
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());
      response = await DioClient().dio.get(
            "/holds",
          );

      List<Map<String, dynamic>> resMap =
          List<Map<String, dynamic>>.from(response.data["holdList"]);
      List<HoldColorModel> hm =
          resMap.map((e) => HoldColorModel.fromJson(e)).toList();
      print(response.data["holdList"]);
      firstAnswerController.HoldOption = hm.map((hold) {
        return hold.colorCode ?? '';
      }).toList();
      firstAnswerController.Holdid = hm.map((hold) {
        return hold.id ?? 0;
      }).toList();
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('DioError: ${e.response?.statusCode}');
          print('Error Response Data: ${e.response?.data}');
        } else {
          print('Error: ${e.message}');
        }
      }
      print("홀드색로딩오류$e");
    }
  }
}
