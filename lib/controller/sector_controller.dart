import 'package:dio/dio.dart';
import 'package:flash/controller/dio_singletone.dart';
import 'package:flash/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

class SectorController extends GetxController {
  final TextEditingController gymCon = TextEditingController();
  final TextEditingController secCon = TextEditingController();
  final TextEditingController adminCon = TextEditingController();
  final TextEditingController settingCon = TextEditingController();
  final TextEditingController remoeCon = TextEditingController();
  var sectorText = ''.obs;
  @override
  void onInit() {
    super.onInit();
    secCon.addListener(() {
      adminCon.text = secCon.text;
    });
  }

  void makeSector() async {
    try {
      DioClient().updateOptions(token: LoginController.accessstoken);

      Response? respone;
      if (remoeCon.text == "") {
        respone = await DioClient().dio.post(
              "/admin/sectorInfos/${gymCon.text}/sectors",
              data: {
                "settingDate": settingCon.text,
              },
              options: Options(
                headers: {
                  'Content-Type': 'application/json',
                },
              ),
            );
      } else {
        respone = await DioClient().dio.post(
              "/admin/sectorInfos/${gymCon.text}/sectors",
              data: {
                "settingDate": settingCon.text,
                "removalDate": remoeCon.text,
              },
              options: Options(
                headers: {
                  'Content-Type': 'application/json',
                },
              ),
            );
      }
      print(respone.data);
      sectorText.value = respone.data["id"].toString() + adminCon.text;
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('sector DioError: ${e.response?.headers}');
          print('Error Response Data: ${e.response?.data}');
        } else {
          print('Error: ${e.message}');
        }
      }
    }
  }
}
