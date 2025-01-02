import 'package:flash/controller/dio/mypage_modify_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModifyToggle extends StatelessWidget {
  final mypageModifyController = Get.put(MypageModifyController());
  // 선택된 버튼 인덱스
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: Colors.grey[200], // 배경색
          borderRadius: BorderRadius.circular(12.0), // 전체 테두리 둥글게
        ),
        child: Obx(
          () {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 프로필 수정 버튼
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      mypageModifyController.toggleIndex.value = 0;
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: mypageModifyController.toggleIndex.value == 0
                            ? Colors.white
                            : Colors.transparent, // 선택된 버튼 배경색
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: Text(
                          "프로필 수정",
                          style: TextStyle(
                            color: mypageModifyController.toggleIndex.value == 0
                                ? Colors.black
                                : Colors.grey, // 선택 여부에 따라 색상 변경
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // 업적 수정 버튼
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      mypageModifyController.toggleIndex.value = 1;
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: mypageModifyController.toggleIndex.value == 1
                            ? Colors.white
                            : Colors.transparent, // 선택된 버튼 배경색
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: Text(
                          "업적 수정",
                          style: TextStyle(
                            color: mypageModifyController.toggleIndex.value == 1
                                ? Colors.black
                                : Colors.grey, // 선택 여부에 따라 색상 변경
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
