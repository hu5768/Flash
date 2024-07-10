import 'package:flash/controller/fake_api_data.dart'; //fake
import 'package:flash/model/fake_api_model.dart'; //fake
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CenterDetailPage extends StatelessWidget {
  // 문제 리스트 페이지
  final int id;
  final String title;

  CenterDetailPage({
    super.key,
    required this.id,
    required this.title,
  });

  final controller = Get.put(FakeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GetX<FakeController>(
        builder: (controller) {
          return ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.FaCursor.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(controller.FaCursor[index].id.toString()),
                  Text(controller.FaCursor[index].title),
                  Text(controller.FaCursor[index].body),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
