import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class FirstAnswerController extends GetxController {
  VideoPlayerController? videoController;
  File? selectVideo;

  var difficultyLabel = '보통이에요'.obs;
  Map<String, String> diffName = {'꿀이에요': '쉬움', '보통이에요': '보통', '어려워요': '어려움'};

  var selectDate = DateTime.now().obs;

  @override
  void dispose() {
    // TODO: implement dispose
    videoController?.dispose();
    super.dispose();
  }
}
