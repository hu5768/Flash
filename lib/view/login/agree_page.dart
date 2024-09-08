import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/const/enum/sort_satate.dart';
import 'package:flash/controller/dio/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgreePage extends StatelessWidget {
  final loginController = Get.put(LoginController());
  final OuathSite ouathLogin;
  AgreePage({super.key, required this.ouathLogin});
  bool ischeck = false;
  @override
  Widget build(BuildContext context) {
    loginController.opneAgree();
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(247, 247, 247, 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Obx(
        () {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Flash 서비스 동의',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: loginController.requireConsent1.value,
                          onChanged: (bool? value) {
                            loginController.requireConsent1.value = value!;
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '[필수] 이용약관',
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        '보기',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: loginController.requireConsent2.value,
                            onChanged: (bool? value) {
                              loginController.requireConsent2.value = value!;
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            '[필수] 개인정보 수집 및 이용 동의',
                            style: TextStyle(fontSize: 13),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {
                        loginController.OpenPI();
                      },
                      child: Text(
                        '보기',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: loginController.requireConsent3.value,
                        onChanged: (bool? value) {
                          loginController.requireConsent3.value = value!;
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '[필수] 만 14세 이상입니다.',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: loginController.emailConsent.value,
                        onChanged: (bool? value) {
                          loginController.emailConsent.value = value!;
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        '[선택] Flash 마케팅 Email 수신동의',
                        style: TextStyle(fontSize: 13),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              loginController.requiredAll.value
                  ? SizedBox(height: 10)
                  : Text(
                      '필수 동의 항목에 체크해주세요!',
                      style: TextStyle(color: Colors.red),
                    ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (loginController.requireConsent1.value &&
                      loginController.requireConsent2.value &&
                      loginController.requireConsent3.value) {
                    if (ouathLogin == OuathSite.GOOGLE) {
                      loginController.googleSignIn(context);
                    } else if (ouathLogin == OuathSite.KAKAO) {
                      loginController.kakaoLogin(context);
                    } else if (ouathLogin == OuathSite.APPLE) {
                      loginController.appleLogin(context);
                    }
                  } else {
                    loginController.requiredAll.value = false;
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  foregroundColor: ColorGroup.selectBtnFGC,
                  backgroundColor: ColorGroup.selectBtnBGC,
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  '동의 후 시작하기',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
