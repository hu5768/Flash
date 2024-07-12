import 'package:flash/Colors/color_group.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoTest extends StatefulWidget {
  const VideoTest({super.key});

  @override
  State<VideoTest> createState() => _VideoTestState();
}

class _VideoTestState extends State<VideoTest> {
  bool iscomplet = false;
  late VideoPlayerController _videoController;
  String uri =
      'https://jp-transcoding-output-bucket-381492123890.s3.ap-northeast-1.amazonaws.com/outputs/index.m3u8';
  String uri2 =
      'https://file-examples.com/storage/fe7bf81a86668bb0a9d006b/2017/04/file_example_MP4_1280_10MG.mp4';

  @override
  void initState() {
    super.initState();
    initvideo();
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

  Future<void> initvideo() async {
    _videoController = VideoPlayerController.network(
      uri,
      // 비디오 URL
    );
    await _videoController.initialize();
    _videoController.play();
    iscomplet = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: Container(
        decoration: const BoxDecoration(color: ColorGroup.modalSBtnBGC),
        child: iscomplet
            ? VideoPlayer(
                _videoController,
              )
            : const Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    backgroundColor: ColorGroup.modalSBtnBGC,
                    color: ColorGroup.selectBtnBGC,
                    strokeWidth: 10,
                  ),
                ),
              ),
      ),
    );
  }
}
