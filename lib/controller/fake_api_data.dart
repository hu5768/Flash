import 'package:dio/dio.dart' as dios;
import 'package:flash/model/fake_api_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const _API_URL = "https://jsonplaceholder.typicode.com/posts";

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
    final dio = dios.Dio();
    dios.Response response;
    response = await dio.get("${"$_API_URL/$page"}/comments");
    List<Map<String, dynamic>> resMap =
        List<Map<String, dynamic>>.from(response.data);
    List<FakeUsers> um = resMap.map((e) => FakeUsers.fromJson(e)).toList();
    page++;
    FaCursor.assignAll(um);
  }

// 추가 로드 데이터
  void nextData() async {
    if (morePage &&
        !loadMoreRunning &&
        scrollController.position.extentAfter < 200) {
      final dio = dios.Dio();
      loadMoreRunning = true;
      dios.Response response;
      response = await dio.get("${"$_API_URL/$page"}/comments");
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
