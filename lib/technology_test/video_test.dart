import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoTest extends StatefulWidget {
  const VideoTest({super.key});

  @override
  State<VideoTest> createState() => _VideoTestState();
}

class _VideoTestState extends State<VideoTest> {
  bool iscomplet = true;
  late VideoPlayerController _controller;
  String uri =
      'https://jp-transcoding-output-bucket-381492123890.s3.ap-northeast-1.amazonaws.com/outputs/index.m3u8';
  String uri2 =
      'https://file-examples.com/storage/fe7bf81a86668bb0a9d006b/2017/04/file_example_MP4_1280_10MG.mp4';

  @override
  void initState() {
    super.initState();
    initvideo();
  }

  Future<void> initvideo() async {
    _controller = VideoPlayerController.network(
      uri2,
      // 비디오 URL
    );
    await _controller.initialize();
    _controller.play();
    iscomplet = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: iscomplet
          ? AspectRatio(
              aspectRatio: 3 / 4,
              child: Container(
                color: Colors.black12,
                child: VideoPlayer(
                  _controller,
                ),
              ),
            )
          : const Text("로딩중?"),
    );
  }
}
