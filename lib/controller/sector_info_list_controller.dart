import 'package:dio/dio.dart';
import 'package:flash/controller/dio_singletone.dart';
import 'package:flash/controller/login_controller.dart';
import 'package:flash/model/sector_info_model.dart';
import 'package:flash/model/sector_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dios;

class SectorInfoListController extends GetxController {
  final ScrollController sectorScrollController = ScrollController();

  var sectorModelList = <SectorInfoModel>[].obs;
  var selectGymName = '강남 더클라임'.obs;
  var selectGymId = 1.obs;
  Future<void> newFetch() async {
    dios.Response response;

    DioClient().updateOptions(token: LoginController.accessstoken);

    try {
      print('고정섹터 받아오기');
      response = await DioClient().dio.request("/sectorInfos");

      List<Map<String, dynamic>> resMap = List<Map<String, dynamic>>.from(
        response.data["sectorInfosResponse"],
      );
      List<SectorInfoModel> sm =
          resMap.map((e) => SectorInfoModel.fromJson(e)).toList();

      sectorModelList.assignAll(sm);
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
