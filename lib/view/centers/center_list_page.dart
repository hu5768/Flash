import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/center_list_data_controller.dart';
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
      color: ColorGroup.BGC,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
    );
  }
}
