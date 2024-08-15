import 'package:flash/controller/user_onboarding_controlle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final UserOnboardingControlle textFieldController =
    Get.put(UserOnboardingControlle());

List<Widget> onboardList = [
  SizedBox(),
  //1 닉네임
  TextField(
    style: TextStyle(fontSize: 24),
    maxLines: null,
    decoration: InputDecoration(
      hintText: '닉네임을 입력해주세요',
      hintStyle: TextStyle(fontSize: 24),
      border: InputBorder.none,
    ),
    onChanged: (value) {
      textFieldController.nickname.value = value;
    },
  ),
//2 인스타그람 id
  TextField(
    style: TextStyle(fontSize: 24),
    maxLines: null,
    decoration: InputDecoration(
      hintText: '인스타그램 id를 입력해주세요',
      hintStyle: TextStyle(fontSize: 24),
      border: InputBorder.none,
    ),
  ),
  //3 키
  TextField(
    style: TextStyle(fontSize: 24),
    maxLines: null,
    decoration: InputDecoration(
      hintText: '키를 입력해주세요',
      hintStyle: TextStyle(fontSize: 24),
      border: InputBorder.none,
    ),
  ),
  //4 리치
  TextField(
    style: TextStyle(fontSize: 24),
    maxLines: null,
    decoration: InputDecoration(
      hintText: '리치 길이를 입력해주세요',
      hintStyle: TextStyle(fontSize: 24),
      border: InputBorder.none,
    ),
  ),
];
