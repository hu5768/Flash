import 'package:flash/controller/dio/comment_controller.dart';
import 'package:flash/view/modals/comment_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentModal extends StatelessWidget {
  CommentModal({super.key});
  final commentController = Get.put(CommentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CommentCard(
                        nickname: '서한유',
                        review: 'hello world!',
                        profileUrl: '',
                      ),
                      CommentCard(
                        nickname: 'climbing_answer',
                        review:
                            'hihihihihihihihihihihihihihihihihihihihihihihihihihihihihihi',
                        profileUrl: '',
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          color: Color.fromRGBO(247, 247, 247, 1),
          border: Border(
            top: BorderSide(
              color: const Color.fromARGB(255, 173, 173, 173), // 테두리 색상
              width: 0.8, // 테두리 두께
            ),
          ),
        ),
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/problem.png',
                height: 45,
                width: 45,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextFormField(
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
                  onPressed: () {},
                  child: Text(
                    '보내기',
                    style: commentController.textEmpty.value
                        ? TextStyle(
                            color: const Color.fromARGB(255, 186, 186, 186),
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
    );
  }
}
