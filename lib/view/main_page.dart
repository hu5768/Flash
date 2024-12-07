import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/dio/answer_data_controller.dart';
import 'package:flash/controller/dio/center_title_controller.dart';
import 'package:flash/controller/dio/mypage_controller.dart';
import 'package:flash/controller/dio/problem_list_controller.dart';
import 'package:flash/controller/problem_filter_controller.dart';
import 'package:flash/controller/problem_sort_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/centers/center_list_page.dart';
import 'package:flash/view/modals/map_modal.dart';
import 'package:flash/view/mypage/mypage.dart';
import 'package:flash/view/problem/problem_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/dio/my_gridview_controller.dart';

class MainPage extends StatefulWidget {
  MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final answerDataController = Get.put(AnswerDataController());
  final problemTitleController = Get.put(ProblemSortController());
  final centerTitleController = Get.put(CenterTitleController());
  final problemFilterController = Get.put(ProblemFilterController());
  final problemListController = Get.put(ProblemListController());
  final mypageController = Get.put(MypageController());
  final myGridviewController = Get.put(MyGridviewController());
  static List<PreferredSizeWidget> _appBars = [
    ProblemAppBar(),
    MyPageAppBar(),
    MyPageAppBar(),
  ];

  String inquiryForm = 'https://forms.gle/HfDBUTidK8kcxWdq8';
  Future<void> OpenForm() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.fromLTRB(0, 0, 30, 10),
          backgroundColor: ColorGroup.BGC,
          titleTextStyle: TextStyle(
            fontSize: 15,
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w700,
          ),
          contentTextStyle: TextStyle(
            fontSize: 13,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
          title: Text('문의하기'),
          content: Text('문의 페이지로 이동하시겠습니까?'),
          actions: [
            TextButton(
              child: Text(
                '취소',
                style: TextStyle(
                  fontSize: 14,
                  color: ColorGroup.selectBtnBGC,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: () {
                AnalyticsService.buttonClick(
                  'Inquiry',
                  '취소',
                  '',
                  '',
                );
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                '확인',
                style: TextStyle(
                  fontSize: 14,
                  color: ColorGroup.selectBtnBGC,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: () async {
                AnalyticsService.buttonClick(
                  'Inquiry',
                  '진짜문의',
                  '',
                  '',
                );
                if (await canLaunchUrl(Uri.parse(inquiryForm))) {
                  await launchUrl(Uri.parse(inquiryForm));
                } else {
                  throw 'Could not launch $inquiryForm';
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    mypageController.fetchMemberData(context);

    AnalyticsService.screenView(
      'MainPage',
      mypageController.userModel.nickName ?? 'yet',
    );
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
        onTap: (int index) async {
          AnalyticsService.buttonClick(
            'MainPage',
            'bottomNavigator_$index',
            centerTitleController.centerTitle.value,
            '',
          );
          if (index == 1) {
            OpenForm();
            return;
          } else if (index == 2) {
            await mypageController.fetchMemberData(context);
            await myGridviewController.fetchData();
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
  Size get preferredSize => Size.fromHeight(60);

  CenterTitleController centerTitleController = Get.find();
  ProblemFilterController problemFilterController = Get.find();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: ColorGroup.BGC, //스크롤시 바뀌는 색
      backgroundColor: ColorGroup.appbarBGC,
      title: Container(
        padding: EdgeInsets.fromLTRB(24, 12, 24, 0),
        height: AppBar().preferredSize.height,
        decoration: const BoxDecoration(),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  AnalyticsService.buttonClick(
                    'MainPage',
                    '센터 선택 버튼',
                    centerTitleController.centerTitle.value,
                    '',
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
              MapButton(centerTitleController: centerTitleController),
            ],
          ),
        ),
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
            centerTitleController.centerTitle.toString(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          );
        }),
        const Icon(Icons.arrow_drop_down),
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
    return GestureDetector(
      onTap: () {
        AnalyticsService.buttonClick(
          'MainPage',
          '일정 버튼',
          centerTitleController.centerTitle.value,
          '',
        );
        showModalBottomSheet(
          backgroundColor: ColorGroup.modalBGC,
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return MapModal(
              mapImgUrl: centerTitleController
                  .centerDetailModel.value.calendarImageUrl!,
              gymName: centerTitleController.centerTitle.string,
            );
          },
        );
      },
      child: const Icon(
        Icons.info_outline,
        size: 32,
      ),
    );
  }
}
