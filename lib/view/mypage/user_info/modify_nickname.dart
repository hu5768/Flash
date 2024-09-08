import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/dio/mypage_controller.dart';
import 'package:flash/controller/dio/mypage_modify_controller.dart';
import 'package:flash/controller/user_onboarding_controlle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ModifyNickname extends StatelessWidget {
  ModifyNickname({super.key});
  final mypageModifyController = Get.put(MypageModifyController());
  final mypageController = Get.put(MypageController());
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
                  '닉네임 변경',
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣ]'),
                    ), // 영어 대소문자, 숫자, 한글만 허용
                    LengthLimitingTextInputFormatter(20),
                  ],
                  keyboardType: TextInputType.text,
                  controller: mypageModifyController.modifyText,
                  style: TextStyle(fontSize: 24),
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: mypageModifyController.rxUserModel.nickName.value,
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
                    return mypageModifyController.nickSafe.value
                        ? SizedBox()
                        : Text(
                            mypageModifyController.nickSafetyCode.value,
                            style:
                                TextStyle(color: Color.fromRGBO(255, 40, 0, 1)),
                          );
                  },
                ),
              ],
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
                              onPressed: () async {
                                mypageModifyController.nickSafe.value =
                                    await mypageController.nickNameOverlap(
                                  mypageModifyController.modifyText.text,
                                );
                                if (mypageModifyController.nickSafe.value) {
                                  mypageModifyController
                                          .rxUserModel.nickName.value =
                                      mypageModifyController.modifyText.text;
                                  Navigator.pop(context);
                                } else {
                                  mypageModifyController.nickSafetyCode.value =
                                      mypageController.nickSafetyCode;
                                }
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
