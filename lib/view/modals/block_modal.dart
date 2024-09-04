import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/dio/user_block_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flutter/material.dart';

class BlockModal extends StatelessWidget {
  final int solutionId;
  final String problemId;
  final String uploaderId;
  final UserBlockController userBlockController = UserBlockController();
  BlockModal({
    super.key,
    required this.solutionId,
    required this.problemId,
    required this.uploaderId,
  });

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
                GestureDetector(
                  onTap: () {
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
                          title: Text('사용자 차단'),
                          content: Text('해당 사용자를 차단하시겠습니까?'),
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
                                '차단',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: ColorGroup.selectBtnBGC,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              onPressed: () {
                                userBlockController.block(uploaderId);
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
                        Icon(Icons.block, color: Colors.black),
                        SizedBox(width: 16),
                        Text(
                          '차단하기',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(height: 1),
                GestureDetector(
                  onTap: () {
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
                          title: Text('게시물 신고'),
                          content: Text('정말 게시물을 신고하시겠습니까?'),
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
                                '신고',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: ColorGroup.selectBtnBGC,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              onPressed: () {
                                userBlockController.report(solutionId);
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
                        Icon(
                          Icons.error_outline,
                          color: const Color.fromARGB(255, 255, 0, 0),
                        ),
                        SizedBox(width: 16),
                        Text(
                          '신고하기',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: const Color.fromARGB(255, 255, 0, 0),
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
