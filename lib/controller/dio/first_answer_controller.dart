import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class FirstAnswerController extends GetxController {
  VideoPlayerController? videoController;
  File? selectVideo;

  List<String> HoldOption = [
    '#FF0000',
    '#124242',
    '#112101',
    '#FF0000',
    '#124242',
    '#112101',
    '#A24212',
    '#A24212',
    '#A24212',
    '#A24212',
  ]; // 홀드 색
  var selectHoldColor = ''.obs;

  List<String> gradeOption = []; // 난이도
  var selectGrade = ''.obs;

  List<String> sectorOption = []; //섹터
  var selectSector = ''.obs;
  List<String> sectorImageUrl = [];
  var sectorImageUrlString = ''.obs;

  var difficultyLabel = '보통이에요'.obs; //체감 난이도
  Map<String, String> diffName = {'꿀이에요': '쉬움', '보통이에요': '보통', '어려워요': '어려움'};

  var selectDate = DateTime.now().obs; // 날짜

  final TextEditingController userOpinionText = TextEditingController(); //한줄평
  final userOpinionFocusNode = FocusNode();

  void SectorSelection(String option, int index) {
    if (option == selectSector.value) {
      selectSector.value = '';
      sectorImageUrlString.value = '';
    } else {
      selectSector.value = option;
      sectorImageUrlString.value = sectorImageUrl[index];
    }
  }

  Future<void> initUpload() async {
    selectHoldColor.value = '';
    selectGrade.value = '';
    sectorImageUrlString.value = '';
    difficultyLabel.value = '보통이에요';
    selectDate = DateTime.now().obs;
    selectSector.value = '';
    userOpinionText.text = '';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    videoController?.dispose();
    super.dispose();
  }
}
