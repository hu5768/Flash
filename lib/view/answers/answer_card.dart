import 'package:flash/controller/solution_delete_controller.dart';
import 'package:flash/view/answers/answer_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AnswerCard extends StatelessWidget {
  final String uploader, review, instagramId, videoUrl;
  final VideoPlayerController videoController;
  final SolutionDeleteController solutionDeleteController =
      SolutionDeleteController();
  final int solutionId;
  AnswerCard({
    super.key,
    required this.uploader,
    required this.review,
    required this.instagramId,
    required this.videoUrl,
    required this.videoController,
    required this.solutionId,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnswerPlayer(
              videoController: videoController,
              useUri: videoUrl,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '제보자: $uploader',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text("@$instagramId"),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '한줄평: $review',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('게시물 삭제'),
                            content: const Text('정말 게시물을 삭제하시겠습니까?'),
                            actions: [
                              TextButton(
                                child: const Text(
                                  '취소',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                onPressed: () async {
                                  await solutionDeleteController.DeleteSolution(
                                    solutionId,
                                  );
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text(
                                  '삭제',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 22, 0, 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.delete, color: Colors.black),
                          SizedBox(width: 16),
                          Text(
                            '삭제하기',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
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
