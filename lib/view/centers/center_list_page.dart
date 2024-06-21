import 'package:flash/controller/center_list_data.dart';
import 'package:flash/view/centers/center_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CenterListPage extends StatelessWidget {
  CenterListPage({super.key});
  final centerController = Get.put(CenterListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: GetX<CenterListController>(
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.centerCon.length,
            itemBuilder: (context, index) {
              return CenterCard(
                id: controller.centerCon[index].id,
                thum: controller.centerCon[index].thum,
                title: controller.centerCon[index].title,
              );
            },
          );
        },
      ),
    );
  }
}
