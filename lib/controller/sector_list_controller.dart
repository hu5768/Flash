import 'package:flash/controller/dio_singletone.dart';
import 'package:flash/controller/login_controller.dart';
import 'package:flash/model/sector_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dios;

class SectorListController extends GetxController {
  final ScrollController sectorScrollController = ScrollController();

  var sectorModelList = <SectorModel>[].obs;
  var selectGymName = '강남 더클라임'.obs;
  var selectGymId = 1.obs;
  Future<void> newFetch() async {
    dios.Response response;

    DioClient().updateOptions(token: LoginController.accessstoken);

    try {
      response = await DioClient().dio.request("/sectors");
      List<Map<String, dynamic>> resMap = List<Map<String, dynamic>>.from(
        response.data["sectorsDetailResponseDtos"],
      );
      List<SectorModel> sm =
          resMap.map((e) => SectorModel.fromJson(e)).toList();

      sectorModelList.assignAll(sm);
    } catch (e) {
      print(e);
    }
  }
}
