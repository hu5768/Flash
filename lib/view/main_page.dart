import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/dio/center_title_controller.dart';
import 'package:flash/controller/problem_filter_controller.dart';
import 'package:flash/controller/problem_sort_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/centers/center_list_page.dart';
import 'package:flash/view/modals/filter_modal.dart';
import 'package:flash/view/modals/map_modal.dart';
import 'package:flash/view/mypage/mypage.dart';
import 'package:flash/view/problem/problem_list.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatefulWidget {
  MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  final problemTitleController = Get.put(ProblemSortController());
  final centerTitleController = Get.put(CenterTitleController());
  final problemFilterController = Get.put(ProblemFilterController());

  static List<PreferredSizeWidget> _appBars = [
    ProblemAppBar(),
    MyPageAppBar(),
    MyPageAppBar(),
  ];

  String inquiryForm = 'https://forms.gle/HfDBUTidK8kcxWdq8';
  Future<void> OpenForm() async {
    if (await canLaunchUrl(Uri.parse(inquiryForm))) {
      await launchUrl(Uri.parse(inquiryForm));
    } else {
      throw 'Could not launch $inquiryForm';
    }
  }

  @override
  Widget build(BuildContext context) {
    centerTitleController.getContext(context);
    return Scaffold(
      backgroundColor: ColorGroup.BGC,
      appBar: _appBars[currentIndex],
      body: IndexedStack(
        index: currentIndex,
        children: [
          ProblemList(),
          Mypage(),
          Mypage(),
        ],
      ),
      //body: CarousellTest(),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: ColorGroup.BGC,
        unselectedItemColor: ColorGroup.modalBtnBGC,
        selectedItemColor: ColorGroup.btnFGC,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          if (index == 1) {
            OpenForm();
            return;
          }
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          /*
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle),
              label: '업로드',
            ),*/
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '문의',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '마이',
          ),
        ],
      ),
    );
  }
}

class MyPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyPageAppBar({
    super.key,
  });

  @override
  Size get preferredSize => Size.fromHeight(52);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        child: Center(
          child: Text(
            '마이페이지',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(33, 33, 33, 1),
            ),
          ),
        ),
      ),
      backgroundColor: ColorGroup.appbarBGC,
    );
  }
}

class ProblemAppBar extends StatelessWidget implements PreferredSizeWidget {
  ProblemAppBar({
    super.key,
  });
  @override
  Size get preferredSize => Size.fromHeight(52);

  CenterTitleController centerTitleController = Get.find();
  ProblemFilterController problemFilterController = Get.find();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: ColorGroup.BGC, //스크롤시 바뀌는 색
      backgroundColor: ColorGroup.appbarBGC,
      title: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        height: AppBar().preferredSize.height,
        decoration: const BoxDecoration(),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MapButton(centerTitleController: centerTitleController),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return CenterListPage();
                    },
                  );
                },
                child:
                    TitleButton(centerTitleController: centerTitleController),
              ),
              Obx(
                () => Stack(
                  clipBehavior: Clip.none,
                  children: [
                    FilterButton(
                      problemFilterController: problemFilterController,
                    ),
                    problemFilterController.allEmpty()
                        ? SizedBox()
                        : Positioned(
                            right: -10,
                            top: -8,
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                color: ColorGroup.selectBtnBGC, // 배경색 설정
                                shape: BoxShape.circle, // 동그란 모양으로 설정
                              ),
                              child: Center(
                                child: Text(
                                  problemFilterController
                                      .countFilter()
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: ColorGroup.BGC,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.problemFilterController,
  });

  final ProblemFilterController problemFilterController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[200], // 배경색 설정
        shape: BoxShape.circle, // 동그란 모양으로 설정
      ),
      child: IconButton(
        onPressed: () {
          problemFilterController.inToTemp();
          showModalBottomSheet(
            backgroundColor: ColorGroup.modalBGC,
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return FilterModal();
            },
          );
        },
        icon: const Icon(Icons.tune),
      ),
    );
  }
}

class TitleButton extends StatelessWidget {
  const TitleButton({
    super.key,
    required this.centerTitleController,
  });

  final CenterTitleController centerTitleController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() {
          return Text(
            //"${centerTitleController.centerTitle} (개발 서버)",
            centerTitleController.centerTitle.toString(),
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          );
        }),
        const Icon(Icons.keyboard_arrow_down_rounded),
      ],
    );
  }
}

class MapButton extends StatelessWidget {
  const MapButton({
    super.key,
    required this.centerTitleController,
  });

  final CenterTitleController centerTitleController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[200], // 배경색 설정
        shape: BoxShape.circle, // 동그란 모양으로 설정
      ),
      child: IconButton(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: ColorGroup.modalBGC,
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return MapModal(
                mapImgUrl: centerTitleController.mapImgUrl,
                gymName: centerTitleController.centerTitle.string,
              );
            },
          );
        },
        icon: const Icon(Icons.map),
      ),
    );
  }
}
