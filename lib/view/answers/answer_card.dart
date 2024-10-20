import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/dio/comment_controller.dart';
import 'package:flash/controller/dio/my_solution_detail_controller.dart';
import 'package:flash/controller/dio/mypage_controller.dart';
import 'package:flash/controller/dio/open_web.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/answers/answer_player.dart';
import 'package:flash/view/modals/block_modal.dart';
import 'package:flash/view/modals/comment_modal.dart';
import 'package:flash/view/modals/manage_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class AnswerCard extends StatefulWidget {
  final String uploader,
      review,
      instagramId,
      videoUrl,
      problemId,
      uploaderId,
      profileUrl;
  final int solutionId, commentCount;
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
                              aspectRatio:
                                  widget.videoController.value.aspectRatio,
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
                            onPressed: () {},
                            icon: Icon(
                              pauseIcon ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: Slider(
                              activeColor: Colors.white,
                              inactiveColor: Color.fromARGB(102, 217, 217, 217),
                              thumbColor:
                                  const Color.fromARGB(0, 255, 255, 255),
                              value: widget
                                  .videoController.value.position.inSeconds
                                  .toDouble(),
                              max: widget
                                  .videoController.value.duration.inSeconds
                                  .toDouble(),
                              onChanged: (double var1) {
                                final position =
                                    Duration(seconds: var1.toInt());
                                widget.videoController.seekTo(position);
                              },
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
          Positioned(
            right: 20,
            bottom: 90,
            child: Column(
              children: [
                IconButton(
                  onPressed: () async {
                    AnalyticsService.buttonClick(
                      'commentClick',
                      '문제해설에서옴',
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
                          profileUrl:
                              mypageController.userModel.profileImageUrl ?? "",
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
                  widget.commentCount.toString(),
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

                      await mySolutionDetailController
                          .fetchData(widget.solutionId);
                      showModalBottomSheet(
                        backgroundColor: ColorGroup.modalBGC,
                        context: context,
                        builder: (BuildContext context) {
                          return widget.isUploader
                              ? ManageModal(
                                  review:
                                      mySolutionDetailController.sdm.review!,
                                  videoUrl: widget.videoUrl,
                                  problemId: widget.problemId,
                                  solutionId: widget.solutionId,
                                  perceivedDifficulty:
                                      mySolutionDetailController
                                              .sdm.perceivedDifficulty ??
                                          '보통',
                                )
                              : BlockModal(
                                  solutionId: widget.solutionId,
                                  problemId: widget.problemId,
                                  uploaderId: widget.uploaderId,
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
