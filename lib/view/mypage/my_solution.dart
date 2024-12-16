import 'package:flash/const/Colors/center_color.dart';
import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/date_form.dart';
import 'package:flash/controller/dio/comment_controller.dart';
import 'package:flash/controller/dio/my_solution_detail_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/modals/comment_modal.dart';

import 'package:flash/view/modals/manage_modal.dart';
import 'package:flash/view/mypage/my_solution_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class MySolution extends StatefulWidget {
  final int solutionId;
  final String profileUrl;

  MySolution({
    super.key,
    required this.solutionId,
    required this.profileUrl,
  });

  @override
  State<MySolution> createState() => _MySolutionState();
}

class _MySolutionState extends State<MySolution> {
  final mySolutionDetailController = Get.put(MySolutionDetailController());
  final commentController = Get.put(CommentController());
  bool iscomplet = false;
  bool pauseIcon = false;
  VideoPlayerController? _videoController;
  @override
  void initState() {
    super.initState();
    initvideo();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> initvideo() async {
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse(mySolutionDetailController.sdm.videoUrl!),
      // 비디오 URL
    );
    try {
      if (!_videoController!.value.isInitialized) {
        await _videoController!.initialize();
        //print('영상 다운');
      }
      iscomplet = true;

      _videoController!.seekTo(Duration.zero);
      _videoController!.play();
      // print('영상 실행 ');
      _videoController!.addListener(() {
        if (_videoController!.value.position ==
            _videoController!.value.duration) {
          // 비디오가 끝났을 때 다시 재생
          _videoController!.seekTo(Duration.zero);
          _videoController!.play();
        }
        if (mounted) {
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
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            /* MySolutionPlayer(
              useUri: mySolutionDetailController.sdm.videoUrl!,
            ),*/
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 0, 0, 0)),
              child: iscomplet
                  ? GestureDetector(
                      onTap: () {
                        if (_videoController!.value.isPlaying) {
                          _videoController!.pause();
                          setState(() {
                            pauseIcon = true;
                          });
                        } else {
                          _videoController!.play();
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
                              height: MediaQuery.of(context).size.height,
                              child: AspectRatio(
                                aspectRatio:
                                    _videoController!.value.aspectRatio,
                                child: VideoPlayer(
                                  _videoController!,
                                ),
                              ),
                            ),
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
            ),
            Positioned(
              top: 90,
              left: 12,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.9),
                      Colors.black.withOpacity(0.6),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formatDateString(
                            mySolutionDetailController.sdm.uploadedAt!,
                          ) +
                          ' 업로드',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      "${mySolutionDetailController.sdm.gymName} ${mySolutionDetailController.sdm.sectorName}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      formatDateString(
                            mySolutionDetailController.sdm.removalDate!,
                          ) +
                          ' 탈거ㆍ' +
                          formatDateString(
                            mySolutionDetailController.sdm.settingDate!,
                          ) +
                          ' 세팅',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                    OverflowTextWithMore(
                      text: mySolutionDetailController.sdm.review!,
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: CenterColor.TheClimbColorList[
                                      mySolutionDetailController
                                          .sdm.difficultyName],
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white, // 테두리 색상
                                    width: 1,
                                  ),
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                mySolutionDetailController.sdm.difficultyName!,
                                style: TextStyle(color: ColorGroup.btnBGC),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            Icons.play_circle_fill,
                            color: Colors.white,
                            size: 24.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (_videoController!.value.isPlaying) {
                                  _videoController!.pause();
                                  setState(() {
                                    pauseIcon = true;
                                  });
                                } else {
                                  _videoController!.play();
                                  setState(() {
                                    pauseIcon = false;
                                  });
                                }
                              },
                              icon: Icon(
                                pauseIcon ? Icons.play_arrow : Icons.pause,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius:
                                        1.0, // thumb 크기를 작게 설정 (기본값 10.0)
                                  ),
                                  overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 6.0,
                                  ), // 오버레이 크기 줄이기
                                  overlayColor: Colors.transparent,
                                ),
                                child: SizedBox(
                                  height: 50,
                                  child: Slider(
                                    activeColor: Colors.white,
                                    inactiveColor:
                                        Color.fromARGB(102, 217, 217, 217),
                                    thumbColor:
                                        const Color.fromARGB(0, 255, 255, 255),
                                    value: _videoController!
                                        .value.position.inSeconds
                                        .toDouble(),
                                    max: _videoController!
                                        .value.duration.inSeconds
                                        .toDouble(),
                                    onChanged: (double var1) {
                                      final position =
                                          Duration(seconds: var1.toInt());
                                      _videoController!.seekTo(position);
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              '${_videoController!.value.position.inMinutes.toString().padLeft(2, '0')}:${_videoController!.value.position.inSeconds.toString().padLeft(2, '0')}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: 90,
              child: Column(
                children: [
                  IconButton(
                    onPressed: () async {
                      AnalyticsService.buttonClick(
                        'commentClick',
                        '내문제해설에서옴',
                        '',
                        '',
                      );
                      commentController.commentText.clear();
                      await commentController.newFetch(widget.solutionId);
                      showModalBottomSheet(
                        backgroundColor: ColorGroup.modalBGC,
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return CommentModal(
                            solutionId: widget.solutionId,
                            profileUrl: widget.profileUrl,
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.comment,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  Text(
                    mySolutionDetailController.sdm.commentsCount.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 60, 60, 60).withOpacity(0.7),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () async {
                        AnalyticsService.buttonClick(
                          'answer',
                          '더보기',
                          '',
                          '',
                        );
                        showModalBottomSheet(
                          backgroundColor: ColorGroup.modalBGC,
                          context: context,
                          builder: (BuildContext context) {
                            return ManageModal(
                              review: mySolutionDetailController.sdm.review!,
                              videoUrl:
                                  mySolutionDetailController.sdm.videoUrl!,
                              problemId: '',
                              solutionId: widget.solutionId,
                              perceivedDifficulty: mySolutionDetailController
                                      .sdm.perceivedDifficulty ??
                                  "보통",
                              solvedDate:
                                  mySolutionDetailController.sdm.solvedDate ??
                                      '2024-12-01',
                              difficulty: mySolutionDetailController
                                  .sdm.difficultyName!,
                              holdColorcode: mySolutionDetailController
                                      .sdm.holdColorCode ??
                                  '',
                              thumbnailImageUrl: mySolutionDetailController
                                      .sdm.thumbnailImageUrl ??
                                  '',
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OverflowTextWithMore extends StatefulWidget {
  final String text;

  OverflowTextWithMore({required this.text});

  @override
  State<OverflowTextWithMore> createState() => _OverflowTextWithMoreState();
}

class _OverflowTextWithMoreState extends State<OverflowTextWithMore> {
  bool moreText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 90,
      child: Align(
        alignment: Alignment.centerLeft,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final textSpan = TextSpan(
              text: widget.text,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            );
            final textPainter = TextPainter(
              text: textSpan,
              maxLines: 1,
              textDirection: TextDirection.ltr,
            );

            textPainter.layout(maxWidth: constraints.maxWidth);

            if (textPainter.didExceedMaxLines && moreText) {
              return Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.text.split('\n').first,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all<EdgeInsets>(
                        EdgeInsets.zero,
                      ),
                      minimumSize:
                          WidgetStateProperty.all(Size.zero), // 최소 크기 제거
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 패딩 제거
                    ),
                    onPressed: () {
                      setState(() {
                        moreText = !moreText;
                      });
                    },
                    child: Text(
                      '...더보기',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return SizedBox(
                height: 30,
                child: TextButton(
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsets>(
                      EdgeInsets.zero,
                    ), // 패딩 제거
                    minimumSize: WidgetStateProperty.all(Size.zero), // 최소 크기 제거
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    setState(() {
                      moreText = !moreText;
                    });
                  },
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
