import 'package:flash/controller/center_list_data.dart';
import 'package:flash/view/centers/center_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CenterListPage extends StatelessWidget {
  CenterListPage({super.key});
  //GetX 이용하여 센터리스트 상태관리
  final centerController = Get.put(CenterListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Container(
          height: AppBar().preferredSize.height,
          decoration: const BoxDecoration(),
          child: const Row(
            children: [
              SizedBox(
                width: 120,
              ),
              Center(
                child: Text(
                  "Flash",
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
      ),
    );
  }
}
