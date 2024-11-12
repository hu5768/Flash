import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flash/const/Colors/center_color.dart';
import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/const/data.dart';
import 'package:flash/const/uploadBaseUrl.dart';
import 'package:flash/controller/dio/dio_singletone.dart';
import 'package:flash/controller/dio/upload_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

//import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_compress/video_compress.dart';

class AnswerUpload extends StatefulWidget {
  final String problemId, gymName, difficulty;

  const AnswerUpload({
    super.key,
    required this.problemId,
    required this.gymName,
    required this.difficulty,
  });

  @override
  State<AnswerUpload> createState() => _AnswerUploadState();
}

class _AnswerUploadState extends State<AnswerUpload> {
  //static const platform = MethodChannel('com.example.filepicker');
  VideoPlayerController? videoController;
  File? _video;
  bool fileLoad = false;
  String difficultyLabel = '보통';
  final TextEditingController userOpinionController = TextEditingController();
  final uploadController = Get.put(UploadController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uploadController.difficultyLabel.value = '보통';
  }

  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();
  }

  Future<void> PickVideo() async {
    print('파일 열기');
    int sizeLimit = 300 * 1024 * 1024;

    setState(() {
      fileLoad = true;
    });
    try {
      //await platform.invokeMethod('openFilePicker');
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
      );

      if (result != null) {
        PlatformFile fileCheck = result.files.first;
        print('압축 시작 압축전 파일 크기: ${fileCheck.size} bytes');
        if (fileCheck.size < sizeLimit) {
          _video = File(result.files.single.path!);

          setState(() {
            videoController = VideoPlayerController.file(_video!)
              ..initialize().then((_) {
                setState(() {});
                videoController!.setVolume(0);
                videoController!.play();
              });
          });
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
    fileLoad = false;
  }

  Future<void> _uploadVideo2() async {
    if (_video == null) return;
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
          _video!.path,
          //info.path!,
          filename: 'test.mp4', // 파일 이름 설정
        ),
        'problemId': widget.problemId,
        'review': userOpinionController.text,
        'perceivedDifficulty': uploadController.difficultyLabel.value,
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
        /* showDialog(
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
              title: Text('업로드 완료'),
              content: Text('영상이 업로드 되었습니다\n답지에 표시될 때까지 시간이 걸릴 수 있습니다.'),
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
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );*/
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
                  '내 풀이 작성',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(33, 33, 33, 1),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (_video == null) return;
                    AnalyticsService.buttonClick(
                      'SolutionUpload',
                      '업로드',
                      widget.gymName,
                      widget.difficulty,
                    );
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
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 240,
                  width: 169,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(248, 0, 0, 0),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: fileLoad
                      ? Container(
                          padding: EdgeInsets.fromLTRB(59.5, 95, 59.5, 95),
                          child: CircularProgressIndicator(
                            backgroundColor: ColorGroup.modalSBtnBGC,
                            color: ColorGroup.selectBtnBGC,
                            strokeWidth: 10,
                          ),
                        )
                      : videoController == null
                          ? null
                          : VideoPlayer(videoController!),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (!fileLoad) {
                      AnalyticsService.buttonClick(
                        'SolutionUpload',
                        '영상선택',
                        widget.gymName,
                        widget.difficulty,
                      );
                      PickVideo();
                    } else {
                      AnalyticsService.buttonClick(
                        'SolutionUpload',
                        '로딩중 영상선택',
                        widget.gymName,
                        widget.difficulty,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    foregroundColor: Color.fromRGBO(0, 87, 255, 1),
                    backgroundColor: Color.fromRGBO(217, 230, 255, 1),

                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ), // 패딩
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24), // 모서리 둥글기
                    ),
                  ),
                  child: Text(
                    '영상 선택하기',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 12),
                        child: Text(
                          '클라이밍장',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(247, 247, 247, 1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          widget.gymName,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),*/
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 12),
                        child: Text(
                          '난이도',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(247, 247, 247, 1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: CenterColor
                                    .TheClimbColorList[widget.difficulty],
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text(
                              widget.difficulty,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
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
  final uploadController = Get.put(UploadController());
  DifficultyChip({
    super.key,
    required this.difficulty,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        bool isSelected = uploadController.difficultyLabel.value == difficulty;
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
          selectedColor: const Color.fromARGB(255, 227, 227, 227),
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
            AnalyticsService.buttonClick(
              'voteDiff',
              difficulty,
              '',
              '',
            );
            uploadController.difficultyLabel.value = difficulty;
          },
        );
      },
    );
  }
}
