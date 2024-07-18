import 'package:dio/dio.dart' as dios;
import 'package:flash/controller/center_title_controller.dart';
import 'package:flash/controller/problem_filter_controller.dart';
import 'package:flash/controller/problem_sort_controller.dart';
import 'package:flash/model/problems_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dio_singletone.dart';

class ProblemListController extends GetxController {
  var problemList = <ProblemModel>[].obs;
  late ScrollController scrollController;
  final CenterTitleController centerTitleController = Get.find();
  final ProblemSortController problemSortController = Get.find();
  final ProblemFilterController problemFilterController = Get.find();

  String nextCursor = "";
  bool loadRunning = false; //데이터 로딩중 여부
  bool morePage = false; //다음 페이지가 있는지 여부
  @override
  void onInit() {
    scrollController = ScrollController()..addListener(nextFetch);
    super.onInit();
    newFetch();
  }

  void newFetch() async {
    dios.Response response;
    loadRunning = true;
    try {
      int gymId = centerTitleController.centerId.value;
      String sortBy = problemSortController.sortkey.value; //정렬
      String sortText = "?sortBy=$sortBy";
      String diffList =
          problemFilterController.allSelection[0].join(','); //난이도 필터
      String diffText = diffList == "" ? "" : "&difficulty=$diffList";
      String secList =
          problemFilterController.allSelection[1].join(','); //섹터 필터
      secList = Uri.encodeComponent(secList);
      String secText = secList == "" ? "" : "&sector=$secList";
      bool hasSol = !problemFilterController.nobodySol.value; //아무도 안푼문제 필터
      String solText = hasSol ? "" : "&has-solution=$hasSol";

      response = await DioClient()
          .dio
          .request("/gyms/$gymId/problems$sortText$diffText$secText$solText");
      List<Map<String, dynamic>> resMap =
          List<Map<String, dynamic>>.from(response.data["problems"]);
      List<ProblemModel> um =
          resMap.map((e) => ProblemModel.fromJson(e)).toList();
      problemList.clear();
      if (um.isNotEmpty) {
        morePage = response.data["meta"]["hasNext"];
        if (morePage) {
          problemList.addAll(um);
          nextCursor = response.data["meta"]["cursor"];
        }

        problemList.assignAll(um);
      }
    } catch (e) {
      print("시작 페이지 로딩 오류$e");
    }
    loadRunning = false;
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void nextFetch() async {
    if (morePage &&
        !loadRunning &&
        scrollController.position.extentAfter < 200) {
      String sortBy = problemSortController.sortkey.value;
      String sortText = "&sortBy=$sortBy";
      int gymId = centerTitleController.centerId.value;
      String diffList = problemFilterController.allSelection[0].join(',');
      String diffText = diffList == "" ? "" : "&difficulty=$diffList";
      String secList =
          problemFilterController.allSelection[1].join(','); //섹터 필터
      secList = Uri.encodeComponent(secList);
      String secText = secList == "" ? "" : "&sector=$secList";
      bool hasSol = !problemFilterController.nobodySol.value;
      String solText = hasSol ? "" : "&has-solution=$hasSol";

      loadRunning = true;
      dios.Response response;
      response = await DioClient().dio.get(
            "/gyms/$gymId/problems?cursor=$nextCursor$sortText$diffText$secText$solText",
          );
      print(
        "/gyms/$gymId/problems?cursor=$nextCursor$sortText$diffText$secText$solText",
      );
      List<Map<String, dynamic>> resMap =
          List<Map<String, dynamic>>.from(response.data["problems"]);
      List<ProblemModel> um =
          resMap.map((e) => ProblemModel.fromJson(e)).toList();
      if (um.isEmpty) {
        morePage = false;
      } else {
        problemList.addAll(um);
        morePage = response.data["meta"]["hasNext"];
        if (morePage) {
          nextCursor = response.data["meta"]["cursor"];
        }
      }
      loadRunning = false;
    }
  }
}
