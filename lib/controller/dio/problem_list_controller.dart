import 'package:dio/dio.dart' as dios;
import 'package:dio/dio.dart';
import 'package:flash/const/data.dart';
import 'package:flash/controller/dio/center_title_controller.dart';
import 'package:flash/controller/dio/hold_color_controller.dart';
import 'package:flash/controller/problem_filter_controller.dart';
import 'package:flash/controller/problem_sort_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/model/problems_model.dart';
import 'package:flash/view/login/login_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dio_singletone.dart';

class ProblemListController extends GetxController {
  var problemList = <ProblemModel>[].obs;
  ScrollController? scrollController;
  final centerTitleController = Get.put(CenterTitleController());
  final problemSortController = Get.put(ProblemSortController());
  final problemFilterController = Get.put(ProblemFilterController());
  final holdColorController = Get.put(HoldColorController());
  String userNickname = 'none';
  dynamic mainContext;

  String nextCursor = "";
  bool loadRunning = false; //데이터 로딩중 여부
  bool morePage = false; //다음 페이지가 있는지 여부
  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController()..addListener(nextFetch);

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  void getContext(context) {
    mainContext = context;
  }

  Future<void> firstConnect() async {
    //앱 최초 접속시

    await centerTitleController.getTitle();
    await newFetch();
    await holdColorController.getHolds();
    AnalyticsService.buttonClick(
      'firstConnect',
      'userNickname',
      '',
      '',
    );
    print('username' + userNickname);
  }

  Future<void> newFetch() async {
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
      bool ishoney = problemFilterController.isHoney.value; //꿀문제 필터
      String honeyText = !ishoney ? "" : "&is-honey=$ishoney";

      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());
      response = await DioClient().dio.get(
            "/gyms/$gymId/problems$sortText$diffText$secText$solText$honeyText",
          );

      List<Map<String, dynamic>> resMap =
          List<Map<String, dynamic>>.from(response.data["problems"]);
      List<ProblemModel> um =
          resMap.map((e) => ProblemModel.fromJson(e)).toList();
      problemList.clear();
      if (um.isNotEmpty) {
        morePage = response.data["meta"]["hasNext"];
        problemList.assignAll(um);
        if (morePage) {
          nextCursor = response.data["meta"]["cursor"];
        } else {
          problemList.add(ProblemModel(id: 'no'));
        }
      } else {
        problemList.add(ProblemModel(id: 'no'));
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('DioError: ${e.response?.statusCode}');
          print('Error Response Data: ${e.response?.data}');
        } else {
          print('Error: ${e.message}');
        }
      }
      print("시작 페이지 로딩 오류$e");
    }
    loadRunning = false;
    /*
 
      scrollController!.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    */
  }

  void ScrollUp() {
    scrollController!.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void goOut() {
    Navigator.pushAndRemoveUntil(
      mainContext,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false, // 스택에 있는 모든 이전 라우트를 제거
    );
  }

  Future<void> FilterApply() async {
    morePage = false;
    await newFetch();
    ScrollUp();
  }

  void nextFetch() async {
    if (morePage &&
        !loadRunning &&
        scrollController!.position.extentAfter < 200) {
      loadRunning = true;
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
      bool ishoney = problemFilterController.isHoney.value; //꿀문제 필터
      String honeyText = !ishoney ? "" : "&is-honey=$ishoney";

      dios.Response response;
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());
      response = await DioClient().dio.get(
            "/gyms/$gymId/problems?cursor=$nextCursor$sortText$diffText$secText$solText$honeyText",
          );

      List<Map<String, dynamic>> resMap =
          List<Map<String, dynamic>>.from(response.data["problems"]);
      List<ProblemModel> um =
          resMap.map((e) => ProblemModel.fromJson(e)).toList();
      if (um.isEmpty) {
        problemList.add(ProblemModel(id: 'no'));
        print('no1');
        morePage = false;
      } else {
        problemList.addAll(um);
        morePage = response.data["meta"]["hasNext"];
        if (morePage) {
          nextCursor = response.data["meta"]["cursor"];
        } else {
          print('no2');
          problemList.add(ProblemModel(id: 'no'));
        }
      }
      loadRunning = false;
    }
  }
}
