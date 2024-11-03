import 'package:flash/const/Colors/color_group.dart';

import 'package:flash/controller/sector_edit_controller.dart';
import 'package:flash/controller/sector_list_controller.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SectorEdit extends StatelessWidget {
  final int sectorId;
  SectorEdit({super.key, required this.sectorId});

  var sectorEditController = Get.put(SectorEditController());
  final sectorListController = Get.put(SectorListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('섹터 수정'),
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
                '섹터 수정',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: sectorEditController.gymCon,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'gym id',
                  fillColor: Colors.white, // 배경색을 흰색으로 설정
                  filled: true, // 배경색을 적용하도록 설정
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: sectorEditController.secCon,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '섹터명',
                  fillColor: Colors.white, // 배경색을 흰색으로 설정
                  filled: true, // 배경색을 적용하도록 설정
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: sectorEditController.adminCon,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'admin name',
                  fillColor: Colors.white, // 배경색을 흰색으로 설정
                  filled: true, // 배경색을 적용하도록 설정
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: sectorEditController.settingCon,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '세팅일',
                  fillColor: Colors.white, // 배경색을 흰색으로 설정
                  filled: true, // 배경색을 적용하도록 설정
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: sectorEditController.remoeCon,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '탈거일',
                  fillColor: Colors.white, // 배경색을 흰색으로 설정
                  filled: true, // 배경색을 적용하도록 설정
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  sectorEditController.EditSector(sectorId);
                  sectorListController.newFetch();
                },
                child: const Text('섹터 생성'),
              ),
              Obx(
                () {
                  return Text(
                    "sector id ${sectorEditController.sectorText.value}",
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
