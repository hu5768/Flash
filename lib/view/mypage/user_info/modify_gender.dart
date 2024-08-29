import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/dio/mypage_modify_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModifyGender extends StatelessWidget {
  ModifyGender({super.key});
  final mypageModifyController = Get.put(MypageModifyController());

  @override
  Widget build(BuildContext context) {
    mypageModifyController.genderTmp.value =
        mypageModifyController.rxUserModel.gender.value;
    return Scaffold(
      backgroundColor: ColorGroup.BGC,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                Text(
                  '성별 변경',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(33, 33, 33, 1),
                  ),
                ),
                SizedBox(width: 40),
              ],
            ),
          ),
        ),
        backgroundColor: ColorGroup.appbarBGC,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () {
                //modify controller에 gender Obs추가하여 시도해보기
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.male),
                      title: Text('남성입니다'),
                      tileColor:
                          mypageModifyController.genderTmp.value == 'MALE'
                              ? Colors.blue.shade100
                              : Colors.grey.shade100,
                      textColor:
                          mypageModifyController.genderTmp.value == 'MALE'
                              ? Colors.blue
                              : Colors.grey,
                      trailing: mypageModifyController.genderTmp.value == 'MALE'
                          ? Icon(Icons.check, color: Colors.blue)
                          : null,
                      onTap: () =>
                          mypageModifyController.genderTmp.value = 'MALE',
                    ),
                    SizedBox(height: 8),
                    ListTile(
                      leading: Icon(Icons.female),
                      title: Text('여성입니다'),
                      tileColor:
                          mypageModifyController.genderTmp.value == 'FEMALE'
                              ? Colors.blue.shade100
                              : Colors.grey.shade100,
                      textColor:
                          mypageModifyController.genderTmp.value == 'FEMALE'
                              ? Colors.blue
                              : Colors.grey,
                      trailing:
                          mypageModifyController.genderTmp.value == 'FEMALE'
                              ? Icon(Icons.check, color: Colors.blue)
                              : null,
                      onTap: () =>
                          mypageModifyController.genderTmp.value = 'FEMALE',
                    ),
                  ],
                );
              },
            ),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      mypageModifyController.rxUserModel.gender.value =
                          mypageModifyController.genderTmp.value;

                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(250, 60),
                      foregroundColor: ColorGroup.selectBtnFGC,
                      backgroundColor: ColorGroup.selectBtnBGC,
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "변경하기",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
