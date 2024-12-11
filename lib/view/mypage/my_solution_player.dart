import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MySolutionPlayer extends StatefulWidget {
  final String useUri;

  const MySolutionPlayer({
    super.key,
    required this.useUri,
  });

  @override
  State<MySolutionPlayer> createState() => _MySolutionPlayerState();
}

class _MySolutionPlayerState extends State<MySolutionPlayer> {
  bool iscomplet = false;
  bool pauseIcon = false;
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    initvideo();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  Future<void> initvideo() async {
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse(widget.useUri),
      // 비디오 URL
    );
    try {
      if (!_videoController.value.isInitialized) {
        await _videoController.initialize();
        //print('영상 다운');
      }
      iscomplet = true;

      _videoController.seekTo(Duration.zero);
      _videoController.play();
      // print('영상 실행 ');
      _videoController.addListener(() {
        if (_videoController.value.position ==
            _videoController.value.duration) {
          // 비디오가 끝났을 때 다시 재생
          _videoController.seekTo(Duration.zero);
          _videoController.play();
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
                if (_videoController.value.isPlaying) {
                  _videoController.pause();
                  setState(() {
                    pauseIcon = true;
                  });
                } else {
                  _videoController.play();
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
                        aspectRatio: _videoController.value.aspectRatio,
                        child: VideoPlayer(
                          _videoController,
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
