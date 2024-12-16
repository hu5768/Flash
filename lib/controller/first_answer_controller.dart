import 'dart:io';
import 'package:flash/controller/dio_singletone.dart';
import 'package:flash/controller/login_controller.dart';
import 'package:flash/model/duplicate_problem_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData hide MultipartFile hide Response;
import 'package:video_player/video_player.dart';
import 'package:dio/dio.dart';

class FirstAnswerController extends GetxController {
  List<String> HoldOption = []; // 홀드 색
  List<int> Holdid = [];
  int selectHoldId = 0;
  var selectHoldColor = ''.obs;

  List<String> gradeOption = []; // 난이도
  var selectGrade = ''.obs;

  List<String> sectorOption = []; //섹터
  var selectSector = ''.obs;
  List<String> sectorImageUrl = [];
  var sectorImageUrlString = ''.obs;
  int selectSectorId = 0;
  List<int> sectorIdList = [];

  var difficultyLabel = '보통이에요'.obs; //체감 난이도
  Map<String, String> diffName = {'꿀이에요': '쉬움', '보통이에요': '보통', '어려워요': '어려움'};
  Map<String, String> diffNameReverse = {
    '쉬움': '꿀이에요',
    '보통': '보통이에요',
    '어려움': '어려워요',
  };
  var selectDate = DateTime.now().obs; // 날짜

  final TextEditingController userOpinionText = TextEditingController(); //한줄평
  final userOpinionFocusNode = FocusNode();
  bool isUpload = false; //최종업로드 여부 업로드 팝업용
  var requiredSelect = false.obs; //필수선택 하면true

  List<DuplicateProblemModel> duplicateList = [];
  PageController duplicatePageController = PageController();
  var duplicatePage = 0.obs;
  void SectorSelection(String option, int index) {
    if (option == selectSector.value) {
      selectSector.value = '';
      sectorImageUrlString.value = '';
    } else {
      selectSector.value = option;
      sectorImageUrlString.value = sectorImageUrl[index];
    }
    selectSectorId = sectorIdList[index];
    requiredCheck();
    duplicatePageController.addListener(() {
      duplicatePage.value = duplicatePageController.page!.round();
    });
  }

  Future<void> initUpload() async {
    selectHoldColor.value = '';
    selectGrade.value = '';
    sectorImageUrlString.value = '';
    difficultyLabel.value = '보통이에요';
    selectDate.value = DateTime.now();
    selectSector.value = '';
    userOpinionText.text = '';
    requiredSelect.value = false;
    duplicatePage.value = 0;
  }

  String findSectorUrl(String sector) {
    String sectorImgUrl = '';
    int index = sectorOption.indexOf(sector);
    if (index != -1) {
      sectorImgUrl = sectorImageUrl[index];
      selectSectorId = index;
    } else
      sectorImgUrl = '';

    return sectorImgUrl;
  }

  Future<void> requiredCheck() async {
    bool tmp = true;
    tmp &= !(selectHoldColor.value == '');
    tmp &= !(selectGrade.value == '');
    tmp &= !(selectSector.value == '');

    requiredSelect.value = tmp;
  }

  Future<bool> duplicateCheck() async {
    bool duplicated = false;
    Response response;
    DioClient().updateOptions(token: LoginController.accessstoken);

    try {
      print('문제 중복확인 get');
      response = await DioClient().dio.get(
            "/problems/duplicate?sectorId=$selectSectorId&holdColorId=$selectHoldId&difficulty=${selectGrade.value}",
          );
      print('중복체크!');
      print(response.data['problems']);
      List<Map<String, dynamic>> resMap =
          List<Map<String, dynamic>>.from(response.data["problems"]);
      duplicateList =
          resMap.map((e) => DuplicateProblemModel.fromJson(e)).toList();
      print(duplicateList);
      duplicated = duplicateList.isNotEmpty;
    } on DioException catch (e) {
      print('중복체크오류$e');
      if (e.response != null) {
        print('DioError: ${e.response?.statusCode}');
        print('Error Response Data: ${e.response?.data}');
      } else {
        print('Error: ${e.message}');
      }
      print('오류 헤더${e.response?.headers}');
      print('오류 바디${e.response?.data}');
    }
    return duplicated;
  }
}
