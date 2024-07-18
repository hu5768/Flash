import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class VideoTest extends StatefulWidget {
  final String useUri;
  const VideoTest({
    super.key,
    required this.useUri,
  });

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
  String uri3 =
      "https://flash-solution-video-output-bucket-975049979695.s3.ap-northeast-2.amazonaws.com/vod/hls/5649383b-ece7-4fcf-816c-29e23376d4e5.m3u8";

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
      widget.useUri,

      // 비디오 URL
    );
    await _videoController.initialize();
    print('영상 다운');
    AnalyticsService.sendVedioEvent('start', widget.useUri);
    _videoController.play();
    iscomplet = true;

    _videoController.addListener(() {
      if (_videoController.value.position == _videoController.value.duration) {
        // 비디오가 끝났을 때 다시 재생
        AnalyticsService.sendVedioEvent('restart', widget.useUri);
        _videoController.seekTo(Duration.zero);
        _videoController.play();
      }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: Container(
        decoration: const BoxDecoration(color: Color.fromARGB(255, 0, 0, 0)),
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
