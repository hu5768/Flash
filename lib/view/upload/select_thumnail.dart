import 'dart:io';

import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/dio/first_answer_controller.dart';
import 'package:flash/view/upload/TransparentSquareThumb.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class SelectThumnail extends StatefulWidget {
  final String videoPath;
  const SelectThumnail({super.key, required this.videoPath});

  @override
  State<SelectThumnail> createState() => _SelectThumnailState();
}

class _SelectThumnailState extends State<SelectThumnail> {
  final firstAnswerController = Get.put(FirstAnswerController());
  List<File> frameThumbnails = [];
  double currentSliderValue = 0;
  int totalFrames = 8;
  VideoPlayerController? videoController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    generateThumbnails();
  }

  @override
  void dispose() {
    super.dispose();
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
    videoController = VideoPlayerController.file(File(widget.videoPath));
    await videoController!.initialize();

    final videoDuration = videoController!.value.duration.inMilliseconds;

    for (int i = 0; i < totalFrames; i++) {
      final timeMs = (videoDuration / totalFrames * i).round();
      print(videoDuration);
      final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: widget.videoPath,
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                Text(
                  '미리보기 이미지 설정',
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
                    color: Color.fromARGB(248, 242, 242, 242),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: videoController == null
                      ? SizedBox()
                      : VideoPlayer(
                          videoController!,
                        ),
                ),
                SizedBox(height: 40),
                // 썸네일 슬라이더
                frameThumbnails.isNotEmpty
                    ? Container(
                        height: 77,
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
                                  divisions: (totalFrames - 1) * 3, //일단 24개
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
          ],
        ),
      ),
    );
  }
}
