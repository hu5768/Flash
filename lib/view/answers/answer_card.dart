import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/dio/comment_controller.dart';
import 'package:flash/controller/dio/my_solution_detail_controller.dart';
import 'package:flash/controller/dio/mypage_controller.dart';
import 'package:flash/controller/dio/open_web.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/modals/block_modal.dart';
import 'package:flash/view/modals/comment_modal.dart';
import 'package:flash/view/modals/manage_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class AnswerCard extends StatefulWidget {
  final String uploader,
      review,
      instagramId,
      videoUrl,
      problemId,
      uploaderId,
      uploaderGender,
      profileUrl;
  final int solutionId, commentCount;
  final double uploaderHeight, uploaderReach;
  final bool isUploader;
  final VideoPlayerController videoController;

  AnswerCard({
    super.key,
    required this.uploader,
    required this.review,
    required this.instagramId,
    required this.videoUrl,
    required this.videoController,
    required this.solutionId,
    required this.problemId,
    required this.uploaderId,
    required this.isUploader,
    required this.profileUrl,
    required this.commentCount,
    required this.uploaderGender,
    required this.uploaderHeight,
    required this.uploaderReach,
  });

  @override
  State<AnswerCard> createState() => _AnswerCardState();
}

class _AnswerCardState extends State<AnswerCard> {
  final commentController = Get.put(CommentController());
  final mypageController = Get.put(MypageController());
  final mySolutionDetailController = Get.put(MySolutionDetailController());

  final OpenWeb openWeb = OpenWeb();
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          /*AnswerPlayer(
            videoController: widget.videoController,
            useUri: widget.videoUrl,
          ),*/
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 0, 0, 0)),
            child: iscomplet
                ? GestureDetector(
                    onTap: () {
                      AnalyticsService.buttonClick(
                        'videoPauseButton',
                        '하단탭',
                        '',
                        '',
                      );
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
                            //height: double.infinity,
                            height: MediaQuery.of(context).size.height,
                            child: AspectRatio(
                              aspectRatio:
                                  widget.videoController.value.aspectRatio,
                              child: VideoPlayer(
                                widget.videoController,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  AnalyticsService.buttonClick(
                                    'commentClick',
                                    '문제해설에서옴',
                                    '',
                                    '',
                                  );
                                  commentController.commentText.clear();
                                  await commentController
                                      .newFetch(widget.solutionId);
                                  showModalBottomSheet(
                                    backgroundColor: ColorGroup.modalBGC,
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) {
                                      return CommentModal(
                                        solutionId: widget.solutionId,
                                        profileUrl: mypageController
                                                .userModel.profileImageUrl ??
                                            "",
                                      );
                                    },
                                  );
                                },
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/icon/comment_icon.svg',
                                    ),
                                    Text(
                                      widget.commentCount.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        height: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () async {
                              AnalyticsService.buttonClick(
                                'answer',
                                '더보기',
                                '',
                                '',
                              );

                              await mySolutionDetailController
                                  .fetchData(widget.solutionId);
                              showModalBottomSheet(
                                backgroundColor: ColorGroup.modalBGC,
                                context: context,
                                builder: (BuildContext context) {
                                  return widget.isUploader
                                      ? ManageModal(
                                          review: mySolutionDetailController
                                              .sdm.review!,
                                          videoUrl: widget.videoUrl,
                                          problemId: widget.problemId,
                                          solutionId: widget.solutionId,
                                          perceivedDifficulty:
                                              mySolutionDetailController.sdm
                                                      .perceivedDifficulty ??
                                                  '보통',
                                          solvedDate: mySolutionDetailController
                                                  .sdm.solvedDate ??
                                              '2024-12-01',
                                          difficulty: mySolutionDetailController
                                              .sdm.difficultyName!,
                                          holdColorcode:
                                              mySolutionDetailController
                                                      .sdm.holdColorCode ??
                                                  '#171717',
                                          thumbnailImageUrl:
                                              mySolutionDetailController
                                                      .sdm.thumbnailImageUrl ??
                                                  '',
                                        )
                                      : BlockModal(
                                          solutionId: widget.solutionId,
                                          problemId: widget.problemId,
                                          uploaderId: widget.uploaderId,
                                        );
                                },
                              );
                            },
                            child: SizedBox(
                              height: 42,
                              width: 42,
                              child: Center(
                                child: const Icon(
                                  Icons.more_horiz_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              AnalyticsService.buttonClick(
                                'profile',
                                '프로필',
                                '',
                                '',
                              );
                            },
                            child: ClipOval(
                              child: widget.profileUrl == ''
                                  ? Image.asset(
                                      'assets/images/problem.png',
                                      height: 45,
                                      width: 45,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      widget.profileUrl,
                                      height: 45,
                                      width: 45,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  AnalyticsService.buttonClick(
                                    'profile',
                                    '닉네임',
                                    '',
                                    '',
                                  );
                                },
                                child: Text(
                                  '${widget.uploader}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              widget.instagramId == ''
                                  ? SizedBox()
                                  : GestureDetector(
                                      onTap: () async {
                                        AnalyticsService.buttonClick(
                                          'profile',
                                          '인스타',
                                          '',
                                          '',
                                        );
                                        await openWeb.OpenInstagram(
                                          widget.instagramId,
                                        );
                                      },
                                      child: Text(
                                        "@${widget.instagramId}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          if (widget.uploaderGender != '')
                            Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255)
                                    .withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                widget.uploaderGender == 'MALE'
                                    ? Icons.male
                                    : Icons.female_outlined,
                                color: Colors.white,
                              ),
                            ),
                          SizedBox(width: 4),
                          if (widget.uploaderHeight != 0)
                            Container(
                              height: 32,
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255)
                                    .withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/icon/height_icon.svg',
                                  ),
                                  Text(
                                    widget.uploaderHeight.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(width: 4),
                          if (widget.uploaderReach != 0)
                            Container(
                              height: 32,
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255)
                                    .withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/icon/width_icon.svg',
                                  ),
                                  Text(
                                    widget.uploaderReach.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  OverflowTextWithMore(text: widget.review),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              AnalyticsService.buttonClick(
                                'videoPauseButton',
                                '중앙탭',
                                '',
                                '',
                              );
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
                                  value: widget
                                      .videoController.value.position.inSeconds
                                      .toDouble(),
                                  max: widget
                                      .videoController.value.duration.inSeconds
                                      .toDouble(),
                                  onChanged: (double var1) {
                                    AnalyticsService.buttonClick(
                                      'videoPauseButton',
                                      '슬라이더 사용',
                                      '',
                                      '',
                                    );
                                    final position =
                                        Duration(seconds: var1.toInt());
                                    widget.videoController.seekTo(position);
                                  },
                                ),
                              ),
                            ),
                          ),
                          Text(
                            '${widget.videoController.value.position.inMinutes.toString().padLeft(2, '0')}:${widget.videoController.value.position.inSeconds.toString().padLeft(2, '0')}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ), //오른쪽 col
        ],
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
            //print("constraints.maxWidth${constraints.maxWidth}");
            //print("한줄 넘냐?${textPainter.didExceedMaxLines}");
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
              return TextButton(
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
              );
            }
          },
        ),
      ),
    );
  }
}
