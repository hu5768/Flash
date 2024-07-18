import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class AnswerPlayer extends StatefulWidget {
  final String useUri;
  const AnswerPlayer({
    super.key,
    required this.useUri,
  });

  @override
  State<AnswerPlayer> createState() => _AnswerPlayerState();
}

class _AnswerPlayerState extends State<AnswerPlayer> {
  bool iscomplet = false;
  late VideoPlayerController _videoController;

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
