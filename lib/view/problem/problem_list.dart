import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/dio/center_title_controller.dart';
import 'package:flash/controller/problem_filter_controller.dart';
import 'package:flash/controller/dio/problem_list_controller.dart';
import 'package:flash/controller/problem_sort_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/modals/moreproblem_modal.dart';
import 'package:flash/view/modals/sort_modal.dart';
import 'package:flash/view/problem/problem_card.dart';
import 'package:flash/view/problem/problem_filter.dart';
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ProblemFilter(),
              GetX<ProblemListController>(
                builder: (controller) {
                  return Container(
                    height: 300,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await problemListController.newFetch();
                        problemListController.ScrollUp();
                      },
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: problemListController.scrollController,
                        itemCount: problemListController.problemList.length,
                        itemBuilder: (context, index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              problemListController.problemList[index].id ==
                                      'no'
                                  ? NoProblemCard()
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
                                      solutionCount: problemListController
                                              .problemList[index]
                                              .solutionCount ??
                                          0,
                                    ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoProblemCard extends StatelessWidget {
  NoProblemCard({
    super.key,
  });

  final CenterTitleController centerTitleController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
      decoration: BoxDecoration(
        color: ColorGroup.cardBGC,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color.fromARGB(255, 153, 153, 153), // 테두리 색상
          width: 1.0, // 테두리 두께
        ),
      ),
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/emptyHodIcon.png'),
            SizedBox(height: 15),
            Text(
              '더 이상 문제가 없습니다',
              style: TextStyle(
                color: const Color.fromARGB(255, 153, 153, 153),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                AnalyticsService.buttonClick(
                  'findProblem',
                  centerTitleController.centerTitle.value,
                  '',
                  '',
                );
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return MoreproblemModal();
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: const Color.fromARGB(255, 153, 153, 153), // 밑줄 색상
                      width: 1.0, // 밑줄 두께
                    ),
                  ),
                ),
                child: Text(
                  '찾으시는 문제가 없으신가요?',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 153, 153, 153),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 0.9,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
