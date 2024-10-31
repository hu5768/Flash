import 'package:flash/controller/dio/comment_controller.dart';
import 'package:flash/view/modals/comment_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentModal extends StatelessWidget {
  final int solutionId;
  final String profileUrl;
  CommentModal({super.key, required this.solutionId, required this.profileUrl});
  final commentController = Get.put(CommentController());
  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.65, //자식 위젯의 크기 받아오는거 함 찾아봐야 됨
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return GestureDetector(
          // onTap: FocusScope.of(context).unfocus,
          onTap: () {
            commentController.focusNode.unfocus();
          },
          child: Scaffold(
            body: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(247, 247, 247, 1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
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
                  Divider(
                    thickness: 0.8,
                  ),
                  Obx(
                    () {
                      return Expanded(
                        child: ListView.builder(
                          controller: commentController.scrollController,
                          itemCount: commentController.commentList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                CommentCard(
                                  nickname: commentController
                                      .commentList[index].nickName
                                      .toString(),
                                  review: commentController
                                      .commentList[index].content
                                      .toString(),
                                  profileUrl: commentController
                                          .commentList[index].profileImageUrl ??
                                      "",
                                  commenterId: commentController
                                      .commentList[index].commenterId
                                      .toString(),
                                  commentId:
                                      commentController.commentList[index].id!,
                                  solutionId: solutionId,
                                  isMine: commentController
                                          .commentList[index].isMine ??
                                      false,
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            bottomNavigationBar: AnimatedPadding(
              padding: EdgeInsets.only(bottom: bottomPadding),
              duration: const Duration(milliseconds: 10),
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(247, 247, 247, 1),
                  border: Border(
                    top: BorderSide(
                      color: const Color.fromARGB(
                        255,
                        173,
                        173,
                        173,
                      ), // 테두리 색상
                      width: 0.8, // 테두리 두께
                    ),
                  ),
                ),
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(
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
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        focusNode: commentController.focusNode,
                        controller: commentController.commentText,
                        //enabled: isEnabled,
                        decoration: InputDecoration(
                          hintText: '댓글을 입력해주세요',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Obx(
                      () {
                        return TextButton(
                          onPressed: () async {
                            await commentController.sendComment(solutionId);
                            commentController.commentText.clear();
                            await commentController.newFetch(solutionId);
                            FocusScope.of(context).unfocus();
                          },
                          child: Text(
                            '보내기',
                            style: commentController.textEmpty.value
                                ? TextStyle(
                                    color: const Color.fromARGB(
                                      255,
                                      186,
                                      186,
                                      186,
                                    ),
                                  )
                                : TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
