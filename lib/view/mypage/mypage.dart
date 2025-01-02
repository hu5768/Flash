import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/const/date_form.dart';
import 'package:flash/controller/dio/my_gridview_controller.dart';
import 'package:flash/controller/dio/mypage_controller.dart';
import 'package:flash/controller/dio/mypage_modify_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/login/login_page.dart';
import 'package:flash/view/mypage/my_grid_view.dart';
import 'package:flash/view/mypage/my_modify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Mypage extends StatefulWidget {
  Mypage({super.key});

  @override
  State<Mypage> createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  final mypageModifyController = Get.put(MypageModifyController());
  final mypageController = Get.put(MypageController());
  MyGridviewController myGridviewController = Get.put(MyGridviewController());
  @override
  Widget build(BuildContext context) {
    AnalyticsService.screenView(
      'MyPage',
      mypageController.userModel.nickName ?? 'yet',
    );
    return Scaffold(
      backgroundColor: ColorGroup.BGC,
      body: SingleChildScrollView(
        controller: myGridviewController.scrollController,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 68,
                        height: 68,
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundImage:
                              mypageController.userModel.profileImageUrl != ''
                                  ? NetworkImage(
                                      mypageController
                                          .userModel.profileImageUrl!,
                                    )
                                  : AssetImage(
                                      'assets/images/profile.png',
                                    ), // 사용자 이미지 URL 사용
                        ),
                      ),
                      SizedBox(width: 12.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mypageController.userModel.nickName ?? " ",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          //SizedBox(height: 4),
                          Text(
                            '@' + mypageController.userModel.instagramId!,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      /*
                      TextButton(
                        onPressed: () async {
                          AnalyticsService.buttonClick(
                            'MyPage',
                            '수정하기',
                            '',
                            '',
                          );
                          if (mypageController.userModel.nickName == null) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                              (route) => false, // 스택에 있는 모든 이전 라우트를 제거
                            );
                          } else {
                            mypageModifyController.fetchMemberData();
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyModify(),
                              ),
                            );
                            //내 정보 다시 가져오기
                            setState(() {});
                          }
                        },
                        child: Text(
                          '수정하기',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    */
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      if (mypageController.userModel.gender != '')
                        Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 238, 238, 238),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            mypageController.userModel.gender == 'MALE'
                                ? Icons.male
                                : Icons.female_outlined,
                            color: const Color.fromARGB(255, 17, 17, 17),
                          ),
                        ),
                      SizedBox(width: 4),
                      if (mypageController.userModel.height != 0)
                        Container(
                          height: 32,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 238, 238, 238),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/icon/height_icon.svg',
                                colorFilter: ColorFilter.mode(
                                  Color.fromARGB(255, 17, 17, 17),
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                formatDouble(mypageController.userModel.height!)
                                    .toString(),
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 17, 17, 17),
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(width: 4),
                      if (mypageController.userModel.reach! != 0)
                        Container(
                          height: 32,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 238, 238, 238),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/icon/width_icon.svg',
                                colorFilter: ColorFilter.mode(
                                  Color.fromARGB(255, 17, 17, 17),
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                formatDouble(mypageController.userModel.reach!)
                                    .toString(),
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 17, 17, 17),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Container(
                        height: 32,
                        padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 132, 0, 255),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            '더클라임 23개 완등!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () async {
                        mypageModifyController.fetchMemberData();
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyModify(),
                          ),
                        );
                        //내 정보 다시 가져오기
                        setState(() {});
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(14, 9.5, 14, 9.5),
                        side: BorderSide(
                          width: 1,
                          color: const Color.fromARGB(
                            255,
                            196,
                            196,
                            196,
                          ),
                        ),
                        foregroundColor:
                            const Color.fromARGB(255, 115, 115, 115),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Text(
                        '프로필 편집',
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 17, 17, 17),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MyGridView(
                profileUrl: mypageController.userModel.profileImageUrl ?? '',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String label;
  final String value;
  final bool cm;
  InfoCard({required this.label, required this.value, required this.cm});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(245, 245, 245, 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              cm
                  ? Text(
                      ' cm',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(187, 187, 187, 1),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
