import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/dio/comment_controller.dart';
import 'package:flash/controller/dio/my_solution_detail_controller.dart';
import 'package:flash/controller/dio/open_web.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/answers/answer_player.dart';
import 'package:flash/view/modals/block_modal.dart';
import 'package:flash/view/modals/comment_modal.dart';
import 'package:flash/view/modals/manage_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class AnswerCard extends StatelessWidget {
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
  final commentController = Get.put(CommentController());
  final mySolutionDetailController = Get.put(MySolutionDetailController());
  final OpenWeb openWeb = OpenWeb();
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
          AnswerPlayer(
            videoController: videoController,
            useUri: videoUrl,
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
                              child: profileUrl == ''
                                  ? Image.asset(
                                      'assets/images/problem.png',
                                      height: 45,
                                      width: 45,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      profileUrl,
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
                                  '$uploader',
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
                              instagramId == ''
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
                                          instagramId,
                                        );
                                      },
                                      child: Text(
                                        "@$instagramId",
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
                  OverflowTextWithMore(text: review),
                ],
              ),
            ),
          ), //오른쪽 col
          Positioned(
            right: 20,
            bottom: 90,
            child: Column(
              children: [
                Icon(
                  Icons.star,
                  color: const Color.fromARGB(255, 255, 157, 0),
                  size: 40,
                ),
                Text(
                  '45',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    commentController.commentText.clear();
                    await commentController.newFetch(solutionId);
                    showModalBottomSheet(
                      backgroundColor: ColorGroup.modalBGC,
                      context: context,
                      //isScrollControlled: true,
                      builder: (BuildContext context) {
                        return CommentModal(solutionId: solutionId);
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
                  commentCount.toString(),
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

                      await mySolutionDetailController.fetchData(solutionId);
                      showModalBottomSheet(
                        backgroundColor: ColorGroup.modalBGC,
                        context: context,
                        builder: (BuildContext context) {
                          return isUploader
                              ? ManageModal(
                                  review:
                                      mySolutionDetailController.sdm.review!,
                                  videoUrl: videoUrl,
                                  problemId: problemId,
                                  solutionId: solutionId,
                                )
                              : BlockModal(
                                  solutionId: solutionId,
                                  problemId: problemId,
                                  uploaderId: uploaderId,
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
