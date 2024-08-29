import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/dio/mypage_modify_controller.dart';
import 'package:flash/controller/user_onboarding_controlle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ModifyHegiht extends StatelessWidget {
  ModifyHegiht({super.key});
  final mypageModifyController = Get.put(MypageModifyController());
  @override
  Widget build(BuildContext context) {
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
                  '키 변경',
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
            TextField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d{0,3}\.?\d{0,1}'),
                ),
              ],
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: mypageModifyController.modifyText,
              style: TextStyle(fontSize: 24),
              maxLines: null,
              decoration: InputDecoration(
                suffixText: 'cm',
                suffixStyle: TextStyle(
                  fontSize: 24,
                  color: Color.fromRGBO(153, 153, 153, 1),
                ),
                hintText:
                    mypageModifyController.rxUserModel.height.value.toString(),
                hintStyle: TextStyle(
                  fontSize: 24,
                  color: Color.fromRGBO(153, 153, 153, 1),
                ),
                border: InputBorder.none,
              ),
              onChanged: (value) {},
            ),
            Obx(
              () {
                return Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: mypageModifyController.isEmpty.value
                          ? ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(250, 60),
                                foregroundColor: ColorGroup.selectBtnFGC,
                                backgroundColor:
                                    Color.fromRGBO(213, 213, 213, 1),
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
                            )
                          : ElevatedButton(
                              onPressed: () {
                                mypageModifyController
                                    .rxUserModel.height.value = double.tryParse(
                                  mypageModifyController.modifyText.text,
                                )!;

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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
