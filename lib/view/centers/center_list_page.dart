import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/dio/center_list_data_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/centers/center_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CenterListPage extends StatelessWidget {
  CenterListPage({super.key});
  //GetX 이용하여 센터리스트 상태관리
  final centerController = Get.put(
    CenterListController(),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: ColorGroup.modalBGC,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 50,
              ),
              const Text(
                "클라이밍장 선택",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: GetX<CenterListController>(
                builder: (controller) {
                  return ListView.builder(
                    itemCount: controller.centerCon.length,
                    itemBuilder: (context, index) {
                      return CenterCard(
                        id: controller.centerCon[index].id,
                        thum: controller.centerCon[index].thumbnailUrl,
                        title: controller.centerCon[index].gymName,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
