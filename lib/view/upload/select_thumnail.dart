import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/dio/first_answer_controller.dart';
import 'package:flash/view/upload/TransparentSquareThumb.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class SelectThumnail extends StatefulWidget {
  const SelectThumnail({super.key});

  @override
  State<SelectThumnail> createState() => _SelectThumnailState();
}

class _SelectThumnailState extends State<SelectThumnail> {
  String? videoPath;
  final firstAnswerController = Get.put(FirstAnswerController());
  List<File> frameThumbnails = [];
  double currentSliderValue = 0;
  int totalFrames = 8;
  VideoPlayerController? videoController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filePicking();
  }

  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();
  }

  Future<void> filePicking() async {
    int sizeLimit = 300 * 1024 * 1024;
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null) {
      PlatformFile fileCheck = result.files.first;
      if (fileCheck.size < sizeLimit) {
        firstAnswerController.selectVideo = File(result.files.single.path!);
        videoPath = firstAnswerController.selectVideo!.path;
        generateThumbnails();
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
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> selectThumbnailFile(int milliseconds) async {
    final tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;

    final String? filePath = await VideoThumbnail.thumbnailFile(
      video: videoPath!,
      imageFormat: ImageFormat.JPEG,
      timeMs: milliseconds, // 초를 밀리초로 변환
      quality: 75, // 품질 설정
      thumbnailPath: tempPath, // 파일 저장 경로
    );
    if (filePath != null) {
      firstAnswerController.thumbnailFile = File(filePath);
    }
  }

  Future<void> generateThumbnails() async {
    final directory = await getTemporaryDirectory();
    final files = directory.listSync(); // 디렉토리 내의 모든 파일/폴더 목록

    for (var file in files) {
      try {
        if (file is File) {
          await file.delete(); // 파일 삭제
        }
      } catch (e) {
        print("파일 삭제 실패: $e");
      }
    }

    List<File> tempThumbnails = [];
    videoController = VideoPlayerController.file(File(videoPath!));
    await videoController!.initialize();

    final videoDuration = videoController!.value.duration.inMilliseconds;

    for (int i = 0; i < totalFrames; i++) {
      final timeMs = (videoDuration / totalFrames * i).round();
      print(videoDuration);
      final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: videoPath!,
        thumbnailPath:
            '${directory.path}/thumb_${DateTime.now().millisecondsSinceEpoch}.png',
        imageFormat: ImageFormat.PNG,
        timeMs: timeMs,
        maxHeight: 100,
        quality: 25,
      );
      if (thumbnailPath != null) {
        tempThumbnails.add(File(thumbnailPath));
      }
    }

    setState(() {
      frameThumbnails = tempThumbnails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        automaticallyImplyLeading: false,
        title: Container(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () async {
                    firstAnswerController.videoController = null;
                    firstAnswerController.selectVideo = null;
                    //selectVideo 가 한번 선택되면 다시 널로 출력이 안되지만 ui에는 null로 표시됨? 왤까
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                Text(
                  '썸네일 설정 페이지',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(33, 33, 33, 1),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  height: 392,
                  width: 225,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(248, 0, 0, 0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: videoController == null
                      ? Container(
                          //로딩중이면 버퍼링
                          padding: EdgeInsets.fromLTRB(62.5, 146, 62.5, 146),
                          child: CircularProgressIndicator(
                            backgroundColor: ColorGroup.modalSBtnBGC,
                            color: ColorGroup.selectBtnBGC,
                            strokeWidth: 13,
                          ),
                        )
                      : FittedBox(
                          // 비율 유지 및 여백 추가
                          fit: BoxFit.contain,
                          child: SizedBox(
                            width: videoController!.value.size.width,
                            height: videoController!.value.size.height,
                            child: AspectRatio(
                              aspectRatio: videoController!.value.aspectRatio,
                              child: VideoPlayer(videoController!),
                            ),
                          ),
                        ),
                ),
                SizedBox(height: 40),
                // 썸네일 슬라이더
                frameThumbnails.isNotEmpty
                    ? Container(
                        height: 77,
                        color: Colors.black,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // 썸네일 트랙
                            Positioned.fill(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: frameThumbnails.map((thumbnail) {
                                  return Image.file(
                                    thumbnail,
                                    width:
                                        MediaQuery.of(context).size.width / 9,
                                    fit: BoxFit.cover,
                                  );
                                }).toList(),
                              ),
                            ),
                            // 드래그 가능한 슬라이더
                            SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  9 *
                                  8, //thum이 조금 남아서 임의로 줄임?
                              child: SliderTheme(
                                data: SliderThemeData(
                                  trackHeight: 0, // 트랙 숨김
                                  thumbShape: TransparentSquareThumb(),

                                  overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 15,
                                  ),
                                ),
                                child: Slider(
                                  min: 0,
                                  max: (totalFrames - 1).toDouble(),
                                  value: currentSliderValue,
                                  divisions: (totalFrames - 1) * 6, //일단 24개
                                  onChanged: (value) {
                                    setState(() {
                                      currentSliderValue = value;
                                    });
                                    final selectedTime = Duration(
                                      milliseconds: (videoController!.value
                                                  .duration.inMilliseconds /
                                              totalFrames *
                                              value)
                                          .round(),
                                    );
                                    videoController!.seekTo(selectedTime);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Center(child: Text("")),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width / 9 * 8,
                  child: ElevatedButton(
                    onPressed: () async {
                      await selectThumbnailFile(
                        videoController!.value.position.inMilliseconds,
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
                      "설정하기",
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
          ],
        ),
      ),
    );
  }
}
