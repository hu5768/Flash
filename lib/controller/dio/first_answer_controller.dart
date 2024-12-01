import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class FirstAnswerController extends GetxController {
  VideoPlayerController? videoController;
  File? selectVideo;

  List<String> HoldOption = [];
  List<String> gradeOption = [];

  List<String> sectorOption = [];
  var sectorSelected = <String>[].obs;
  List<String> sectorImageUrl = [];
  var sectorImageUrlString = ''.obs;

  var difficultyLabel = '보통이에요'.obs;
  Map<String, String> diffName = {'꿀이에요': '쉬움', '보통이에요': '보통', '어려워요': '어려움'};

  var selectDate = DateTime.now().obs;

  void SectorSelection(String option, int index) {
    if (sectorSelected.contains(option)) {
      sectorSelected.remove(option);
      sectorImageUrlString.value = '';
    } else {
      sectorSelected.clear();
      sectorSelected.add(option);
      sectorImageUrlString.value = sectorImageUrl[index];
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    videoController?.dispose();
    super.dispose();
  }
}
