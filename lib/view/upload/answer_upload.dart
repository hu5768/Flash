import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flash/const/Colors/center_color.dart';
import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/const/data.dart';
import 'package:flash/controller/dio/dio_singletone.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flutter/material.dart';
//import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

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
  VideoPlayerController? videoController;
  File? _video;
  final TextEditingController userOpinionController = TextEditingController();

  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();
  }

  Future<void> PickVideo() async {
    print('파일 열기');
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
      );
      if (result != null) {
        _video = File(result.files.single.path!);

        setState(() {
          videoController = VideoPlayerController.file(_video!)
            ..initialize().then((_) {
              setState(() {});
              videoController!.setVolume(0);
              videoController!.play();
            });
        });
      }
    } catch (e) {
      print("비디오 선택 오류 $e");
    }
  }

/*
  Future<void> _uploadVideo() async {
    if (_video == null) return;
    print('업로드 시작');
    try {
      //get에서 url 받아오기
      final presignedUrlResponse = await DioClient().dio.get(
            'https://1rpjfkrhnj.execute-api.ap-northeast-2.amazonaws.com/dev/solutions/presigned-url',
          );
      print("get요청 받는중");
      final presignedUrlData = presignedUrlResponse.data;
      print(presignedUrlData);
      final uploadUrl = presignedUrlData['body']['upload_url'];
      final fileName = presignedUrlData['body']['file_name'];

      List<int> videoBytes = await _video!.readAsBytes();
// s3에 put
      print('s3에  put 하는중');
      final uploadResponse = await DioClient().dio.put(
            uploadUrl,
            data: Stream.fromIterable(videoBytes.map((e) => [e])),
            options: Options(
              headers: {
                "Content-Type": "video/mp4",
                "Content-Length": videoBytes.length.toString(),
              },
            ),
          );
// put 성공하면
      if (uploadResponse.statusCode == 200) {
        print("s3 put 완료" + fileName);

        final apiResponse = await DioClient().dio.post(
          'https://1rpjfkrhnj.execute-api.ap-northeast-2.amazonaws.com/dev/solutions',
          data: {
            'problem_id': widget.problemId,
            'video_name': fileName,
            'uploader': 'Flash',
            'review': userOpinionController.text,
            'instagram_id': 'climbing_answer',
          },
        );
        if (apiResponse.statusCode == 200) {
          print("최종 업로드 완료!");
          showDialog(
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
                content: Text('영상이 업로드 되었습니다'),
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
          );
        }
      }
    } on DioException catch (e) {
      print('영상 업로드 오류$e');
      print('오류 헤더${e.response?.headers}');
      print('오류 바디${e.response?.data}');
    }
  }
*/
  Future<void> _uploadVideo2() async {
    if (_video == null) return;
    print('업로드 시작');
    final token = await storage.read(key: ACCESS_TOKEN_KEY);
    DioClient().updateOptions(token: token.toString());

    List<int> videoBytes = await _video!.readAsBytes();

    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          _video!.path,
          filename: 'test.mp4', // 파일 이름 설정
        ),
        'problemId': widget.problemId,
        'review': userOpinionController.text,
      });

      final apiResponse = await DioClient().dio.post(
            'https://upload.dev.climbing-answer.com/upload/',
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
    AnalyticsService.screenView('UploadPage');
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
                          title: Text('업로드 완료'),
                          content:
                              Text('영상이 업로드 되었습니다\n답지에 표시될 때까지 시간이 걸릴 수 있습니다.'),
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
                  decoration: BoxDecoration(
                    color: Color.fromARGB(248, 0, 0, 0),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: videoController == null
                      ? null
                      : VideoPlayer(videoController!),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    PickVideo();
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
                      Padding(
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
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 24, 0, 12),
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
