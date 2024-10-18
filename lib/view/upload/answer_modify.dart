import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flash/const/Colors/center_color.dart';
import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/const/data.dart';
import 'package:flash/controller/dio/answer_modify_controller.dart';
import 'package:flash/controller/dio/dio_singletone.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class AnswerModify extends StatefulWidget {
  final String problemId, gymName, videoUrl, review;
  final int solutionId;
  const AnswerModify({
    super.key,
    required this.solutionId,
    required this.problemId,
    required this.gymName,
    required this.videoUrl,
    required this.review,
  });

  @override
  State<AnswerModify> createState() => _AnswerModifyState();
}

class _AnswerModifyState extends State<AnswerModify> {
  final TextEditingController userOpinionController = TextEditingController();
  final answerModifyController = Get.put(AnswerModifyController());

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userOpinionController.text = widget.review;
    AnalyticsService.screenView('ModifyPage', '');
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                Text(
                  '내 풀이 수정',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(33, 33, 33, 1),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    AnalyticsService.buttonClick(
                      'AnswerModify',
                      '수정',
                      '',
                      widget.solutionId.toString(),
                    );
                    await answerModifyController.userReviewFetch(
                      widget.videoUrl,
                      userOpinionController.text,
                      widget.solutionId,
                    );

                    Navigator.pop(context);
                  },
                  child: Text('수정', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: ColorGroup.appbarBGC,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 24, 0, 12),
                        child: Text(
                          '체감 난이도',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(247, 247, 247, 1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            DifficultyChip(difficulty: '쉬움'),
                            DifficultyChip(difficulty: '보통'),
                            DifficultyChip(difficulty: '어려움'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 24, 0, 12),
                        child: Text(
                          '한줄평',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(247, 247, 247, 1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextField(
                          controller: userOpinionController,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: '한줄평을 작성해주세요',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DifficultyChip extends StatelessWidget {
  final String difficulty;
  final answerModifyController = Get.put(AnswerModifyController());
  DifficultyChip({
    super.key,
    required this.difficulty,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        bool isSelected =
            answerModifyController.difficultyLabel.value == difficulty;
        return ChoiceChip(
          showCheckmark: false,
          label: SizedBox(
            width: 60,
            child: Center(
              child: Text(
                difficulty,
                style: TextStyle(
                  fontSize: 17,
                  color: isSelected
                      ? const Color.fromARGB(255, 63, 63, 63)
                      : const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),
          backgroundColor: ColorGroup.btnBGC,
          selectedColor: const Color.fromARGB(255, 211, 211, 211),
          side: BorderSide(
            color: isSelected
                ? const Color.fromARGB(255, 107, 107, 107)
                : Colors.transparent,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              16,
            ),
          ),
          selected: isSelected,
          onSelected: (value) {
            answerModifyController.difficultyLabel.value = difficulty;
          },
        );
      },
    );
  }
}
