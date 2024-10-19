import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/dio/center_title_controller.dart';
import 'package:flash/controller/problem_filter_controller.dart';
import 'package:flash/controller/dio/problem_list_controller.dart';
import 'package:flash/controller/problem_sort_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/modals/filter_modal.dart';
import 'package:flash/view/modals/moreproblem_modal.dart';
import 'package:flash/view/modals/sort_modal.dart';
import 'package:flash/view/problem/problem_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProblemList extends StatelessWidget {
  ProblemList({super.key});
  final ProblemSortController problemTitleController = Get.find();

  final ProblemFilterController problemFilterController = Get.find();
  final problemListController = Get.put(ProblemListController());
  final CenterTitleController centerTitleController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorGroup.BGC,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          SortedButton(problemTitleController: problemTitleController),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              GetX<ProblemListController>(
                builder: (controller) {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await problemListController.newFetch();
                        problemListController.ScrollUp();
                      },
                      child: ListView.builder(
                        controller: problemListController.scrollController,
                        itemCount: problemListController.problemList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              problemListController.problemList[index].id ==
                                      'no'
                                  ? Center(
                                      child: Column(
                                        children: [
                                          /*ElevatedButton(
                                            onPressed: () {},
                                            child: Text('찾으시는 문제가 없으신가요?'),
                                          ),*/
                                          Text(
                                            '더 이상 문제가 없습니다',
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          GestureDetector(
                                            onTap: () {
                                              AnalyticsService.buttonClick(
                                                'findProblem',
                                                centerTitleController
                                                    .centerTitle.value,
                                                '',
                                                '',
                                              );
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return MoreproblemModal();
                                                },
                                              );
                                            },
                                            child: Text(
                                              '찾으시는 문제가 없으신가요?',
                                              style: TextStyle(
                                                fontSize: 13,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 70,
                                          ),
                                        ],
                                      ),
                                    )
                                  : ProblemCard(
                                      gymName: centerTitleController
                                          .centerTitle.value,
                                      id: problemListController
                                          .problemList[index].id
                                          .toString(),
                                      sector: problemListController
                                          .problemList[index].sector
                                          .toString(),
                                      difficulty: problemListController
                                          .problemList[index].difficulty
                                          .toString(),
                                      settingDate: problemListController
                                          .problemList[index].settingDate
                                          .toString(),
                                      removalDate: problemListController
                                          .problemList[index].removalDate
                                          .toString(),
                                      hasSolution: problemListController
                                          .problemList[index].hasSolution!,
                                      imageUrl: problemListController
                                          .problemList[index].imageUrl
                                          .toString(),
                                      isHoney: problemListController
                                              .problemList[index].isHoney ??
                                          false,
                                    ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
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
          AnalyticsService.buttonClick(
            'MyPage',
            '정렬버튼',
            '',
            '',
          );
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
              Obx(
                () {
                  return Text(
                    problemTitleController.sorttitle.toString(),
                    style: TextStyle(fontSize: 17),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
