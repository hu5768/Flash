import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/dio/comment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentManageModal extends StatelessWidget {
  final int commentId, solutionId;
  CommentManageModal({
    super.key,
    required this.commentId,
    required this.solutionId,
  });
  final commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 8, 24, 50),
      decoration: BoxDecoration(
        color: Color.fromRGBO(247, 247, 247, 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color.fromARGB(213, 213, 213, 255),
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /*
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {},
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 22, 0, 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.edit, color: Colors.black),
                        SizedBox(width: 16),
                        Text(
                          '수정하기',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: Color.fromRGBO(246, 246, 246, 1),
                ),*/
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          actionsPadding: EdgeInsets.fromLTRB(0, 0, 30, 10),
                          backgroundColor: ColorGroup.BGC,
                          titleTextStyle: TextStyle(
                            fontSize: 15,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w700,
                          ),
                          contentTextStyle: TextStyle(
                            fontSize: 13,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          title: Text('댓글 삭제'),
                          content: Text('정말 댓글을 삭제하시겠습니까?'),
                          actions: [
                            TextButton(
                              child: Text(
                                '취소',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: ColorGroup.selectBtnBGC,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text(
                                '삭제',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: ColorGroup.selectBtnBGC,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              onPressed: () async {
                                await commentController.DeleteComment(
                                  commentId,
                                );
                                await commentController.newFetch(solutionId);
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 22, 0, 22),
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
    );
  }
}
