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
  bool pauseIcon = false;

  @override
  void initState() {
    super.initState();

    initvideo();
  }

  Future<void> initvideo() async {
    try {
      if (!widget.videoController.value.isInitialized) {
        await widget.videoController.initialize();
        //print('영상 다운');
      }
      iscomplet = true;
      widget.videoController.seekTo(Duration.zero);
      widget.videoController.addListener(() {
        if (widget.videoController.value.position ==
            widget.videoController.value.duration) {
          // 비디오가 끝났을 때 다시 재생
          widget.videoController.seekTo(Duration.zero);
          widget.videoController.play();
        }
        if (mounted) {
          //slider 초기화를 위함
          setState(() {});
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
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(color: Color.fromARGB(255, 0, 0, 0)),
      child: iscomplet
          ? GestureDetector(
              onTap: () {
                if (widget.videoController.value.isPlaying) {
                  widget.videoController.pause();
                  setState(() {
                    pauseIcon = true;
                  });
                } else {
                  widget.videoController.play();
                  setState(() {
                    pauseIcon = false;
                  });
                }
              },
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  FittedBox(
                    fit: BoxFit.contain,
                    child: SizedBox(
                      height: 720,
                      child: AspectRatio(
                        aspectRatio: widget.videoController.value.aspectRatio,
                        child: VideoPlayer(
                          widget.videoController,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: pauseIcon
                        ? Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 60, 60, 60)
                                  .withOpacity(0.7), // 배경색 설정
                              shape: BoxShape.circle, // 동그란 모양으로 설정
                            ),
                            child: const Icon(
                              Icons.pause,
                              color: Colors.white,
                              size: 50,
                            ),
                          )
                        : SizedBox(),
                  ),
                ],
              ),
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
    );
  }
}
