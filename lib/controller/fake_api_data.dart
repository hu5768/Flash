import 'package:dio/dio.dart' as dios;
import 'package:flash/model/fake_api_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dio_singletone.dart';

class FakeController extends GetxController {
  var FaCursor = <FakeUsers>[].obs;
  late ScrollController scrollController;
  int page = 1; //시작 페이지는 1
  bool loadMoreRunning = false; //데이터 로딩중 여부
  bool morePage = true; //다음 페이지가 있는지 여부
  @override
  void onInit() {
    scrollController = ScrollController()..addListener(nextData);
    super.onInit();
    fetchData();
  }

// 시작 로드 데이터
  void fetchData() async {
    dios.Response response;
    try {
      response = await DioClient().dio.get("/$page/comments");
      List<Map<String, dynamic>> resMap =
          List<Map<String, dynamic>>.from(response.data);
      List<FakeUsers> um = resMap.map((e) => FakeUsers.fromJson(e)).toList();
      page++;
      FaCursor.clear();

      FaCursor.assignAll(um);
    } catch (e) {
      List<FakeUsers> um = [
        FakeUsers(id: 1, title: '오류오류오류', body: '1'),
      ];
      FaCursor.assignAll(um);
    }
  }

// 추가 로드 데이터
  void nextData() async {
    if (morePage &&
        !loadMoreRunning &&
        scrollController.position.extentAfter < 200) {
      loadMoreRunning = true;
      dios.Response response;
      response = await DioClient().dio.get("/$page/comments");
      List<Map<String, dynamic>> resMap =
          List<Map<String, dynamic>>.from(response.data);
      List<FakeUsers> um = resMap.map((e) => FakeUsers.fromJson(e)).toList();
      if (um.isNotEmpty) {
        //남은 데이터가 있을경우
        FaCursor.addAll(um);
        print(page);
      } else {
        morePage = false;
      }
      loadMoreRunning = false;

      page++; //hi
    }
  }
}
