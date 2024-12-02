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
import 'package:flash/view/modals/upload/vote_select_modal.dart';
import 'package:flash/view/upload/select_thumnail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

//import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class FirstAnswerUpload extends StatefulWidget {
  final String gymName, sector;

  const FirstAnswerUpload({
    super.key,
    required this.gymName,
    required this.sector,
  });

  @override
  State<FirstAnswerUpload> createState() => _AnswerUploadState();
}

class _AnswerUploadState extends State<FirstAnswerUpload> {
  //static const platform = MethodChannel('com.example.filepicker');

  bool fileLoad = false;
  String difficultyLabel = '보통';

  final firstAnswerController = Get.put(FirstAnswerController());
  final centerTitleController = Get.put(CenterTitleController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstAnswerController.difficultyLabel.value = '보통';
  }

  @override
  void dispose() {
    firstAnswerController.videoController = null;
    super.dispose();
  }

  Future<void> PickVideo() async {
    int sizeLimit = 300 * 1024 * 1024;
    setState(() {
      fileLoad = true;
    });
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
      );
      if (result != null) {
        PlatformFile fileCheck = result.files.first;
        print('압축 시작 압축전 파일 크기: ${fileCheck.size} bytes');
        if (fileCheck.size < sizeLimit) {
          firstAnswerController.selectVideo = File(result.files.single.path!);

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectThumnail(
                videoPath: firstAnswerController.selectVideo!.path,
              ),
              allowSnapshotting: true,
            ),
          );
          setState(() {
            firstAnswerController.videoController =
                VideoPlayerController.file(firstAnswerController.selectVideo!)
                  ..initialize().then((_) {
                    setState(() {});
                    firstAnswerController.videoController!.play();
                  });
          });

          firstAnswerController.videoController!.play();
        } else {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                actionsPadding: EdgeInsets.fromLTRB(0, 0, 30, 10),
                backgroundColor: ColorGroup.BGC,
                titleTextStyle: TextStyle(
                  fontSize: 15,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w700,
                ),
                contentTextStyle: TextStyle(
                  fontSize: 13,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                title: Text('파일 용량 초과'),
                content: Text('300mb이상의 영상은 업로드 할 수 없습니다!'),
                actions: [
                  TextButton(
                    child: Text(
                      '확인',
                      style: TextStyle(
                        fontSize: 17,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (e) {
      print("비디오 선택 오류 $e");
    }
    setState(() {
      fileLoad = false;
    });
  }

  Future<void> _uploadVideo2() async {
    if (firstAnswerController.selectVideo == null) return;
    print('업로드 시작');
    final token = await storage.read(key: ACCESS_TOKEN_KEY);
    DioClient().updateOptions(token: token.toString());

    //List<int> videoBytes = await _video!.readAsBytes();

/*
    final info = await VideoCompress.compressVideo(
      _video!.path,
      quality: VideoQuality
          .MediumQuality, // 압축 품질 설정 (LowQuality, MediumQuality, HighQuality)
      deleteOrigin: false, // 원본 파일 삭제 여부
    );
    print('압축 성공 압축된 비디오 파일 크기: ${info?.filesize} bytes');
*/

    try {
      //   if (info == null) {
      //      print('압축 실패');
      //   } else {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          firstAnswerController.selectVideo!.path,
          //info.path!,
          filename: 'test.mp4', // 파일 이름 설정
        ),
        //  'problemId': widget.problemId,
        'review': firstAnswerController.userOpinionText.text,
        'perceivedDifficulty': firstAnswerController.difficultyLabel.value,
      });

      final apiResponse = await DioClient().dio.post(
            '${uploadServerUrl}upload/',
            data: formData,
            options: Options(
              contentType: 'multipart/form-data',
            ),
          );
      if (apiResponse.statusCode == 200) {
        print("최종 업로드 완료!");
      }
      //  }
    } on DioException catch (e) {
      print('영상 업로드 오류$e');
      if (e.response != null) {
        print('DioError: ${e.response?.statusCode}');
        print('Error Response Data: ${e.response?.data}');
      } else {
        print('Error: ${e.message}');
      }
      print('오류 헤더${e.response?.headers}');
      print('오류 바디${e.response?.data}');
    }
  }

  @override
  Widget build(BuildContext context) {
    AnalyticsService.screenView('UploadPage', '');
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
                    '내 풀이 업로드',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(33, 33, 33, 1),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (firstAnswerController.selectVideo == null) return;

                      _uploadVideo2();
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            actionsPadding: EdgeInsets.fromLTRB(0, 0, 30, 10),
                            backgroundColor: ColorGroup.BGC,
                            titleTextStyle: TextStyle(
                              fontSize: 15,
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w700,
                            ),
                            contentTextStyle: TextStyle(
                              fontSize: 13,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                            title: Text('업로드 시작'),
                            content: Text(
                              '영상이 업로드를 요청했습니다.\n답지에 표시될 때까지 시간이 걸릴 수 있습니다.',
                            ),
                            actions: [
                              TextButton(
                                child: Text(
                                  '확인',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                      Navigator.of(context).pop();
                    },
                    child: Text('업로드', style: TextStyle(fontSize: 16)),
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
                          color: Color.fromARGB(248, 242, 242, 242),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: fileLoad
                            ? Container(
                                padding:
                                    EdgeInsets.fromLTRB(44.5, 107, 44.5, 107),
                                child: CircularProgressIndicator(
                                  backgroundColor: ColorGroup.modalSBtnBGC,
                                  color: ColorGroup.selectBtnBGC,
                                  strokeWidth: 10,
                                ),
                              )
                            : firstAnswerController.videoController == null
                                ? Container(
                                    padding:
                                        EdgeInsets.fromLTRB(30, 125, 30, 125),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (!fileLoad) {
                                          PickVideo();
                                        } else {}
                                      },
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
                                        '영상 선택하기',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                : VideoPlayer(
                                    firstAnswerController.videoController!,
                                  ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 136,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('홀드 색'),
                            SizedBox(height: 8),
                            HoldSelectModal(),
                            SizedBox(height: 16),
                            Text('난이도'),
                            SizedBox(height: 8),
                            GradeSelectModal(),
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
                      Obx(
                        () {
                          String mapImgUrl = centerTitleController
                                  .centerDetailModel.value.mapImageUrl ??
                              "";

                          return mapImgUrl != ''
                              ? SizedBox(
                                  height: 112,
                                  width: double.infinity,
                                  child: Image.network(
                                    firstAnswerController
                                                .sectorImageUrlString.value !=
                                            '' //섹터 이미지가 없으면 맵이미지 보여줌
                                        ? firstAnswerController
                                            .sectorImageUrlString.value
                                        : centerTitleController
                                            .centerDetailModel
                                            .value
                                            .mapImageUrl!,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const SizedBox(
                                        width: 350,
                                        child: Text(
                                          "지도를 불러오지 못했습니다.",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : SizedBox();
                        },
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                        child: Text(
                          '섹터',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SectorFilter(),
                      SizedBox(height: 20),
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
                      SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
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
                        ),
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

class SectorFilter extends StatelessWidget {
  SectorFilter({
    super.key,
  });

  var firstAnswerController = Get.put(FirstAnswerController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: firstAnswerController.sectorOption.length,
        itemBuilder: (context, index) {
          return Obx(
            () {
              final option = firstAnswerController.sectorOption[index];
              final isSelected =
                  option == firstAnswerController.selectSector.value;
              return Container(
                height: 30,
                padding: EdgeInsets.only(right: 12),
                child: ChoiceChip(
                  selected: isSelected,
                  visualDensity: VisualDensity(vertical: 0.0),
                  showCheckmark: false,
                  label: Align(
                    alignment: Alignment(0, -1.2),
                    child: Text(
                      option,
                      style: TextStyle(
                        fontSize: 14,
                        color: isSelected
                            ? Colors.white
                            : Color.fromARGB(255, 17, 17, 17),
                        height: 0,
                      ),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  selectedColor: const Color.fromARGB(255, 0, 87, 255),
                  side: BorderSide(
                    color: isSelected
                        ? Color.fromARGB(255, 0, 87, 255)
                        : Color.fromARGB(255, 196, 196, 196),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                  ),
                  onSelected: (bool selected) {
                    firstAnswerController.SectorSelection(
                      option,
                      index,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
