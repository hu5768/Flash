import 'package:dio/dio.dart';
import 'package:flash/const/data.dart';
import 'package:flash/controller/answer_carousel_controller.dart';
import 'package:flash/model/my_solution_model.dart';
import 'package:flash/view/mypage/my_grid_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dios;

import 'dio_singletone.dart';

class MyGridviewController extends GetxController {
  var solutionList = <MySolutionModel>[].obs;

  Future<void> fetchData() async {
    dios.Response response;

    try {
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());

      response = await DioClient().dio.get(
            "/solutions",
          );
      List<Map<String, dynamic>> resMapList =
          List<Map<String, dynamic>>.from(response.data["mySolutions"]);

      List<MySolutionModel> sm =
          resMapList.map((e) => MySolutionModel.fromJson(e)).toList();
      solutionList.clear();
      solutionList.assignAll(sm);
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('마이페이지 해설 데이터 로딩 실패DioError: ${e.response?.statusCode}');
          print('Error Response Data: ${e.response?.data}');
        } else {
          print('Error: ${e.message}');
        }
      }
    }
  }
}
