import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/honey_controlle.dart';

import 'package:flash/controller/sector_edit_controller.dart';
import 'package:flash/controller/sector_list_controller.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HoneyPage extends StatelessWidget {
  final String problemId;
  HoneyPage({super.key, required this.problemId});

  var honeyControlle = Get.put(HoneyControlle());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('꿀 수정'),
      ),
      backgroundColor: ColorGroup.BGC,
      body: Center(
        child: SizedBox(
          width: 600,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Text(
                '꿀값',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: honeyControlle.honeyCon,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '꿀값',
                  fillColor: Colors.white, // 배경색을 흰색으로 설정
                  filled: true, // 배경색을 적용하도록 설정
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  honeyControlle.honeySet(problemId);
                },
                child: const Text('섹터 생성'),
              ),
              Obx(
                () {
                  return Text(
                    "sector id ${honeyControlle.heonyText.value}",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
