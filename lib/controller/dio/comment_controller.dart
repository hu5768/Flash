import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  TextEditingController commentText = TextEditingController();
  var textEmpty = true.obs;
  @override
  void onInit() {
    super.onInit();
    commentText.addListener(() {
      // 텍스트가 비어 있으면 true, 아니면 false
      textEmpty.value = commentText.text.isEmpty;
    });
  }
}
