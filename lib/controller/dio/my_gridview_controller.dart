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
  ScrollController? scrollController;
  String cursor = '';
  bool loadRunning = false; //데이터 로딩중 여부
  bool morePage = false;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController()..addListener(nextFetch);

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  Future<void> newFetch() async {
    dios.Response response;
    loadRunning = true;
    try {
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());

      response = await DioClient().dio.get(
            "/solutions",
          );
      List<Map<String, dynamic>> resMapList =
          List<Map<String, dynamic>>.from(response.data["solutions"]);

      print("$cursor and $morePage");
      List<MySolutionModel> sm =
          resMapList.map((e) => MySolutionModel.fromJson(e)).toList();
      solutionList.clear();
      if (sm.isNotEmpty) {
        cursor = response.data["meta"]["cursor"] ?? '';
        morePage = response.data["meta"]["hasNext"] ?? false;
        solutionList.addAll(sm);
      } else {
        morePage = false;
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('마이페이지 첫 해설 데이터 로딩 실패DioError: ${e.response?.statusCode}');
          print('Error Response Data: ${e.response?.data}');
        } else {
          print('Error: ${e.message}');
        }
      }
    }
    loadRunning = false;
  }

  Future<void> nextFetch() async {
    bool oneDown = false;
    for (ScrollPosition position in scrollController!.positions) {
      if (position.extentAfter < 100) oneDown = true;
      //print("연결된 ScrollView: ${position.extentAfter}");
    }
    if (!(morePage &&
            !loadRunning &&
            oneDown /*&&
        scrollController!.position.extentAfter < 200*/
        )) return;
    loadRunning = true;
    dios.Response response;
    print('nextfecth');
    try {
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());

      response = await DioClient().dio.get(
            "/solutions?cursor=${cursor}",
          );
      List<Map<String, dynamic>> resMapList =
          List<Map<String, dynamic>>.from(response.data["solutions"]);

      print("$cursor and $morePage");
      List<MySolutionModel> sm =
          resMapList.map((e) => MySolutionModel.fromJson(e)).toList();
      if (sm.isNotEmpty) {
        cursor = response.data["meta"]["cursor"] ?? '';
        morePage = response.data["meta"]["hasNext"] ?? false;
        solutionList.addAll(sm);
      } else {
        morePage = false;
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print(
            '마이페이지 nextfecth 해설 데이터 로딩 실패DioError: ${e.response?.statusCode}',
          );
          print('Error Response Data: ${e.response?.data}');
        } else {
          print('Error: ${e.message}');
        }
      }
    }
    loadRunning = false;
  }

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
