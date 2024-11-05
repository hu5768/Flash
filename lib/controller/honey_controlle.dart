import 'package:dio/dio.dart';
import 'package:flash/controller/dio_singletone.dart';
import 'package:flash/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

class HoneyControlle extends GetxController {
  final TextEditingController honeyCon = TextEditingController();
  var heonyText = ''.obs;

  void honeySet(String problemId) async {
    try {
      DioClient().updateOptions(token: LoginController.accessstoken);

      Response respone = await DioClient().dio.patch(
            "/admin/problems/$problemId/perceivedDifficulty",
            data: {
              "perceivedDifficulty": int.parse(honeyCon.text),
            },
            options: Options(
              headers: {
                'Content-Type': 'application/json',
              },
            ),
          );

      print(respone.data);
      heonyText.value = '${respone.data["isHoney"]} 수정';
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('honey DioError: ${e.response?.headers}');
          print('Error Response Data: ${e.response?.data}');
        } else {
          print('Error: ${e.message}');
        }
      }
    }
  }
}
