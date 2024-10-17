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
          Text(
            '문의하기 또는 DM으로 찾으시는 문제 정보를 보내주세요!\n빠른 시일 내에 추가하도록 하겠습니다.\n* 사진을 보내주시면 더 빠르게 추가할 수 있습니다!',
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
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    openWeb.OpenInstagram('climbing_answer');
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 22, 0, 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.message, color: Colors.black),
                        SizedBox(width: 16),
                        Text(
                          '인스타그램dm으로 문의하기',
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
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    if (await canLaunchUrl(Uri.parse(inquiryForm))) {
                      await launchUrl(Uri.parse(inquiryForm));
                    } else {
                      throw 'Could not launch $inquiryForm';
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 22, 0, 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.notifications, color: Colors.black),
                        SizedBox(width: 16),
                        Text(
                          '구글폼으로 문의하기',
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
