import 'package:dio/dio.dart';
import 'package:flash/const/data.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dios;

import '../../model/my_solution_detail_model';
import 'dio_singletone.dart';

class MySolutionDetailController extends GetxController {
  late MySolutionDetailModel sdm;
  Future<void> fetchData(int solutionId) async {
    dios.Response response;

    try {
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());

      response = await DioClient().dio.get(
            "/solutions/$solutionId",
          );
      Map<String, dynamic> res = Map<String, dynamic>.from(response.data);
      sdm = MySolutionDetailModel.fromJson(res);
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('마이페이지 해설 디테일 로딩 실패DioError: ${e.response?.statusCode}');
          print('Error Response Data: ${e.response?.data}');
        } else {
          print('Error: ${e.message}');
        }
      }
    }
  }
}
