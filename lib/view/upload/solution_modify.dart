import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/const/data.dart';
import 'package:flash/const/uploadBaseUrl.dart';
import 'package:flash/controller/date_form.dart';
import 'package:flash/controller/dio/center_title_controller.dart';
import 'package:flash/controller/dio/dio_singletone.dart';
import 'package:flash/controller/dio/first_answer_controller.dart';

import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/modals/upload/grade_select_modal.dart';
import 'package:flash/view/modals/upload/hold_select_modal.dart';
import 'package:flash/view/modals/upload/next_upload_modal/next_grade_modal.dart';
import 'package:flash/view/modals/upload/next_upload_modal/next_hold_modal.dart';
import 'package:flash/view/modals/upload/vote_select_modal.dart';
import 'package:flash/view/upload/select_thumnail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

//import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class SolutionModify extends StatefulWidget {
  final String videoUrl;
  final int solutionId;
  const SolutionModify({
    super.key,
    required this.solutionId,
    required this.videoUrl,
  });

  @override
  State<SolutionModify> createState() => _SolutionModifyState();
}

class _SolutionModifyState extends State<SolutionModify> {
  //static const platform = MethodChannel('com.example.filepicker');

  final firstAnswerController = Get.put(FirstAnswerController());
  final centerTitleController = Get.put(CenterTitleController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    firstAnswerController.videoController?.pause();
    firstAnswerController.videoController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AnalyticsService.screenView('SolutionModifyPage', '');
    return GestureDetector(
      onTap: () {
        firstAnswerController.userOpinionFocusNode.unfocus();
      },
      child: Scaffold(
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
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: ColorGroup.appbarBGC,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 294,
                        width: 169,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: firstAnswerController.thumbnailImageUrl == ''
                              ? Color.fromARGB(248, 0, 0, 0)
                              : Color.fromARGB(248, 242, 242, 242),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: firstAnswerController.fileLoad //영상 로딩중인지 여부
                            ? Container(
                                //로딩중이면 버퍼링
                                padding:
                                    EdgeInsets.fromLTRB(44.5, 107, 44.5, 107),
                                child: CircularProgressIndicator(
                                  backgroundColor: ColorGroup.modalSBtnBGC,
                                  color: ColorGroup.selectBtnBGC,
                                  strokeWidth: 10,
                                ),
                              )
                            : firstAnswerController.thumbnailImageUrl ==
                                    '' // 썸내일이 존재하는지
                                ? Container(
                                    //존재 안하면 선택화면
                                    padding:
                                        EdgeInsets.fromLTRB(30, 125, 30, 125),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        foregroundColor:
                                            Color.fromRGBO(0, 87, 255, 1),
                                        backgroundColor:
                                            Color.fromRGBO(217, 230, 255, 1),
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            24,
                                          ), // 모서리 둥글기
                                        ),
                                      ),
                                      child: Text(
                                        '썸내일 선택하기',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                : Stack(
                                    //존재하면 썸내일 보여주기
                                    children: [
                                      Center(
                                        child: Image.network(
                                          firstAnswerController
                                              .thumbnailImageUrl,
                                        ),
                                      ), /*
                                      Positioned(
                                        left: 12,
                                        bottom: 12,
                                        child: SizedBox(
                                          height: 35,
                                          width: 65,
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              foregroundColor: Color.fromRGBO(
                                                102,
                                                102,
                                                102,
                                                1,
                                              ),
                                              backgroundColor: Color.fromRGBO(
                                                238,
                                                238,
                                                238,
                                                1,
                                              ),
                                              padding: EdgeInsets.zero,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  24,
                                                ), // 모서리 둥글기
                                              ),
                                            ),
                                            child: Text(
                                              '변경',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 12,
                                        bottom: 12,
                                        child: SizedBox(
                                          height: 35,
                                          width: 35,
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              foregroundColor: Color.fromRGBO(
                                                102,
                                                102,
                                                102,
                                                1,
                                              ),
                                              backgroundColor: Color.fromRGBO(
                                                238,
                                                238,
                                                238,
                                                1,
                                              ),
                                              padding: EdgeInsets.zero,
                                              shape: const CircleBorder(),
                                            ),
                                            child: Icon(
                                              Icons.search,
                                            ),
                                          ),
                                        ),
                                      ),*/
                                    ],
                                  ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      /*if (firstAnswerController.thumbnailFile != null) 썸내일 추출확인
                        SizedBox(
                          height: 100,
                          child: Image.file(
                            firstAnswerController.thumbnailFile!,
                          ),
                        ),*/
                      SizedBox(
                        width: 136,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('홀드 색'),
                            SizedBox(height: 8),
                            NextHoldModal(),
                            SizedBox(height: 16),
                            Text('난이도'),
                            SizedBox(height: 8),
                            NextGradeModal(),
                            SizedBox(height: 16),
                            Text('체감 난이도'),
                            SizedBox(height: 8),
                            VoteSelectModal(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                        child: Text(
                          '날짜',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          DateTime? dateTmp;
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12), // 모서리 둥글게
                                ),
                                child: Theme(
                                  data: ThemeData.light().copyWith(
                                    dialogBackgroundColor:
                                        Colors.white, // 배경 흰색
                                    colorScheme: ColorScheme.light(
                                      primary: Colors.blue, // 선택된 날짜 색상 (파란색)
                                      onPrimary: Colors.white, // 선택된 날짜의 텍스트 색상
                                      surface: Colors.white, // 달력의 기본 배경색
                                    ),
                                    textTheme: TextTheme(
                                      bodyMedium: TextStyle(
                                        color: Colors.black,
                                      ), // 텍스트 색상 (검은색)
                                    ),
                                  ),
                                  child: SizedBox(
                                    height: 300,
                                    child: CalendarDatePicker(
                                      initialDate: firstAnswerController
                                          .selectDate.value,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime.now(),
                                      onDateChanged: (DateTime date) {
                                        dateTmp = date;
                                        Navigator.pop(context, date);
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          );

                          if (dateTmp != null) {
                            firstAnswerController.selectDate.value = dateTmp!;
                          }
                        },
                        child: Container(
                          height: 58,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            border: Border.all(
                              color: const Color.fromARGB(
                                255,
                                196,
                                196,
                                196,
                              ), // 테두리 색상
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Obx(
                              () {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      formatDateDate(
                                        firstAnswerController.selectDate.value,
                                      ),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text('변경'),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 28),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
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
                          border: Border.all(
                            color: const Color.fromARGB(
                              255,
                              196,
                              196,
                              196,
                            ), // 테두리 색상
                            width: 1,
                          ),
                          color: Color.fromRGBO(255, 255, 255, 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: firstAnswerController.userOpinionText,
                          focusNode: firstAnswerController.userOpinionFocusNode,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: '한줄평을 작성해주세요',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Obx(
                        () {
                          return SizedBox(
                            height: 60,
                            width: double.infinity,
                            child: firstAnswerController.requiredSelect.value
                                ? ElevatedButton(
                                    onPressed: () async {
                                      await firstAnswerController
                                          .userReviewFetch(
                                        widget.videoUrl,
                                        widget.solutionId,
                                      );
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: ColorGroup.selectBtnFGC,
                                      backgroundColor: ColorGroup.selectBtnBGC,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      "업로드",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: () async {},
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: const Color.fromARGB(
                                        255,
                                        255,
                                        255,
                                        255,
                                      ),
                                      backgroundColor: const Color.fromARGB(
                                        255,
                                        238,
                                        238,
                                        238,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      "업로드",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                          );
                        },
                      ),
                      SizedBox(height: 40),
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
