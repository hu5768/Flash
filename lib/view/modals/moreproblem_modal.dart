import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/answer_carousel_controller.dart';
import 'package:flash/controller/dio/answer_data_controller.dart';
import 'package:flash/controller/dio/answer_modify_controller.dart';
import 'package:flash/controller/dio/my_gridview_controller.dart';
import 'package:flash/controller/dio/my_solution_detail_controller.dart';
import 'package:flash/controller/dio/open_web.dart';
import 'package:flash/controller/dio/solution_delete_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/upload/answer_modify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreproblemModal extends StatelessWidget {
  MoreproblemModal({
    super.key,
  });
  final OpenWeb openWeb = OpenWeb();
  final String inquiryForm = 'https://forms.gle/EocPBiWyHXJxY3Bj8';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      backgroundColor: const Color.fromARGB(
        255,
        255,
        255,
        255,
      ),
      titlePadding: EdgeInsets.fromLTRB(
        45,
        36,
        45,
        0,
      ),
      titleTextStyle: TextStyle(
        fontSize: 24,
        color: const Color.fromARGB(
          255,
          0,
          0,
          0,
        ),
        fontWeight: FontWeight.w600,
      ),
      title: Center(
        child: Text(
          '문제를 제보해주세요!',
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            textAlign: TextAlign.center,
            '사진을 같이 보내주시면\n훨씬 더 수월한 제보가 가능합니다.',
            style: TextStyle(
              fontSize: 14,
              color: const Color.fromARGB(
                255,
                0,
                0,
                0,
              ),
            ),
          ),
          SizedBox(height: 16),
          // 익명제보 버튼
          SizedBox(
            width: 272,
            height: 49,
            child: OutlinedButton(
              onPressed: () async {
                AnalyticsService.buttonClick(
                  'moreProblem',
                  'googleform',
                  '',
                  '',
                );
                if (await canLaunchUrl(Uri.parse(inquiryForm))) {
                  await launchUrl(Uri.parse(inquiryForm));
                } else {
                  throw 'Could not launch $inquiryForm';
                }
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color.fromARGB(
                  255,
                  116,
                  116,
                  116,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    6,
                  ),
                ),
                side: BorderSide(
                  color: const Color.fromARGB(
                    255,
                    196,
                    196,
                    196,
                  ),
                ),
              ),
              child: Text(
                "익명으로 제보",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            width: 272,
            height: 49,
            child: OutlinedButton(
              onPressed: () {
                AnalyticsService.buttonClick(
                  'moreProblem',
                  '인스타그램dm',
                  '',
                  '',
                );
                openWeb.OpenInstagram('climbing_answer');
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color.fromARGB(
                  255,
                  116,
                  116,
                  116,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    6,
                  ),
                ),
                side: BorderSide(
                  color: const Color.fromARGB(
                    255,
                    196,
                    196,
                    196,
                  ),
                ),
              ),
              child: Text(
                "인스타그램 DM으로 제보",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            width: 272,
            height: 49,
            child: TextButton(
              onPressed: () {
                AnalyticsService.buttonClick(
                  'moreProblem',
                  '취소',
                  '',
                  '',
                );
                Navigator.of(
                  context,
                ).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(
                  255,
                  116,
                  116,
                  116,
                ),
              ),
              child: Text(
                "취소",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
