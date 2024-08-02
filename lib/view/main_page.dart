import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/center_title_controller.dart';
import 'package:flash/controller/mainpage_controller.dart';
import 'package:flash/controller/problem_filter_controller.dart';
import 'package:flash/controller/problem_sort_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/centers/center_list_page.dart';
import 'package:flash/view/modals/filter_modal.dart';
import 'package:flash/view/modals/map_modal.dart';
import 'package:flash/view/modals/sort_modal.dart';
import 'package:flash/view/mypage/mypage.dart';
import 'package:flash/view/problem/problem_list.dart';
import 'package:flash/view/report/report_page.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  MainPage({
    super.key,
  });
  final problemTitleController = Get.put(ProblemSortController());
  final centerTitleController = Get.put(CenterTitleController());
  final problemFilterController = Get.put(ProblemFilterController());
  final mainpageController = Get.put(MainpageController());
  @override
  Widget build(BuildContext context) {
    AnalyticsService.screenView(
      'main_page',
      centerTitleController.centerTitle.string,
    );
    return Scaffold(
      backgroundColor: ColorGroup.BGC,
      appBar: AppBar(
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
                    AnalyticsService.buttonClick(
                      '문제리스트 페이지',
                      '센터 리스트 버튼',
                      centerTitleController.centerTitle.toString(),
                    );
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
      ),
      body: GetX<MainpageController>(
        builder: (controller) {
          return IndexedStack(
            index: mainpageController.currentIndex.value,
            children: [
              ProblemList(),
              Mypage(),
              Mypage(),
            ],
          );
        },
      ),
      //body: CarousellTest(),
      floatingActionButton:
          SortedButton(problemTitleController: problemTitleController),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: ColorGroup.BGC,
          unselectedItemColor: ColorGroup.modalBtnBGC,
          selectedItemColor: ColorGroup.btnFGC,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          currentIndex: mainpageController.currentIndex.value,
          onTap: (int index) {
            mainpageController.currentIndex.value = index;
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
      ),
    );
  }
}

class SortedButton extends StatelessWidget {
  const SortedButton({
    super.key,
    required this.problemTitleController,
  });

  final ProblemSortController problemTitleController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 115,
      height: 60,
      child: FloatingActionButton(
        foregroundColor: ColorGroup.btnFGC,
        backgroundColor: ColorGroup.btnBGC,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return const SortModal();
            },
          );
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 25,
              ),
              Text(
                problemTitleController.sorttitle.toString(),
                style: TextStyle(fontSize: 17),
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
          AnalyticsService.buttonClick(
            '문제리스트 페이지',
            '지도 버튼',
            centerTitleController.centerTitle.toString(),
          );
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
