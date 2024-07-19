import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AnswerPlayer extends StatefulWidget {
  final String useUri;
  final VideoPlayerController videoController;
  const AnswerPlayer({
    super.key,
    required this.useUri,
    required this.videoController,
  });

  @override
  State<AnswerPlayer> createState() => _AnswerPlayerState();
}

class _AnswerPlayerState extends State<AnswerPlayer> {
  bool iscomplet = false;
  //late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    initvideo();
  }

  Future<void> initvideo() async {
    /*_videoController = VideoPlayerController.network(
      widget.useUri,

      // 비디오 URL
    );*/
    try {
      if (!widget.videoController.value.isInitialized) {
        await widget.videoController.initialize();
        //print('영상 다운');
      }
      iscomplet = true;
      widget.videoController.seekTo(Duration.zero);
      //widget.videoController.play();
      // print('영상 실행 ');
      widget.videoController.addListener(() {
        if (widget.videoController.value.position ==
            widget.videoController.value.duration) {
          // 비디오가 끝났을 때 다시 재생
          widget.videoController.seekTo(Duration.zero);
          widget.videoController.play();
        }
      });

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('영상 카드 만들기 오류 $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: Container(
        decoration: const BoxDecoration(color: Color.fromARGB(255, 0, 0, 0)),
        child: iscomplet
            ? VideoPlayer(
                widget.videoController,
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
