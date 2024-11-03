import 'package:dio/dio.dart';
import 'package:flash/controller/dio_singletone.dart';
import 'package:flash/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

class SectorEditController extends GetxController {
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

  Future<void> textSet(
    String gymId,
    String sector,
    String admin,
    String settingDate,
    String removeDate,
  ) async {
    gymCon.text = gymId;
    secCon.text = sector;
    adminCon.text = admin;
    settingCon.text = settingDate;
    remoeCon.text = removeDate;
    sectorText.value = '';
  }

  void EditSector(int sectorId) async {
    try {
      DioClient().updateOptions(token: LoginController.accessstoken);

      Response respone = await DioClient().dio.put(
            "/admin/sectors/$sectorId",
            data: {
              "sectorName": secCon.text,
              "adminSectorName": adminCon.text,
              "settingDate": settingCon.text,
              "removalDate": remoeCon.text,
              "gymId": int.parse(gymCon.text),
            },
            options: Options(
              headers: {
                'Content-Type': 'application/json',
              },
            ),
          );

      print(respone.data);
      sectorText.value = '${respone.data["id"]}수정됨';
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
