import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/dio/center_title_controller.dart';
import 'package:flash/controller/problem_filter_controller.dart';
import 'package:flash/controller/dio/problem_list_controller.dart';
import 'package:flash/controller/problem_sort_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/modals/filter_modal.dart';
import 'package:flash/view/modals/sort_modal.dart';
import 'package:flash/view/problem/problem_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProblemList extends StatelessWidget {
  ProblemList({super.key});
  final ProblemSortController problemTitleController = Get.find();

  final ProblemFilterController problemFilterController = Get.find();
  final scrollController = Get.put(ProblemListController());
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
                    child: ListView.builder(
                      controller: scrollController.scrollController,
                      itemCount: scrollController.problemList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProblemCard(
                              gymName: centerTitleController.centerTitle.value,
                              id: scrollController.problemList[index].id
                                  .toString(),
                              sector: scrollController.problemList[index].sector
                                  .toString(),
                              difficulty: scrollController
                                  .problemList[index].difficulty
                                  .toString(),
                              settingDate: scrollController
                                  .problemList[index].settingDate
                                  .toString(),
                              removalDate: scrollController
                                  .problemList[index].removalDate
                                  .toString(),
                              hasSolution: scrollController
                                  .problemList[index].hasSolution!,
                              imageUrl: scrollController
                                  .problemList[index].imageUrl
                                  .toString(),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
              //const ProblemCard(sector: 'Flat'),
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
