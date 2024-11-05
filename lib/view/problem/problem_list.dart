import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/center_title_controller.dart';
import 'package:flash/controller/problem_filter_controller.dart';
import 'package:flash/controller/problem_list_controller.dart';
import 'package:flash/controller/problem_sort_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/answers/answers_carousell_page.dart';

import 'package:flash/view/modals/sort_modal.dart';
import 'package:flash/view/problem/problem_card.dart';
import 'package:flash/view/problem/problem_filter.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProblemList extends StatelessWidget {
  ProblemList({super.key});

  final problemTitleController = Get.put(ProblemSortController());
  final problemFilterController = Get.put(ProblemFilterController());
  final scrollController = Get.put(ProblemListController());
  final CenterTitleController centerTitleController = Get.find();
  final TextEditingController idCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorGroup.BGC,
      body: Row(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400,
            ),
            child: Column(
              children: [
                TextField(
                  controller: idCon,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '',
                    fillColor: Colors.white, // 배경색을 흰색으로 설정
                    filled: true, // 배경색을 적용하도록 설정
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print("문제id${idCon.value}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AnswersCarousell(id: idCon.text),
                            allowSnapshotting: true,
                          ),
                        );
                      },
                      child: const Text('문제 탐색'),
                    ),
                    Obx(
                      () => ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return const SortModal();
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(115, 40),
                          side: BorderSide(
                            color: problemTitleController.sortkey.toString() ==
                                    'recommand'
                                ? ColorGroup.modalBtnBGC
                                : ColorGroup.selectBtnBGC,
                          ),
                          foregroundColor:
                              problemTitleController.sortkey.toString() ==
                                      'recommand'
                                  ? ColorGroup.btnFGC
                                  : ColorGroup.selectBtnBGC,
                          backgroundColor:
                              problemTitleController.sortkey.toString() ==
                                      'recommand'
                                  ? ColorGroup.btnBGC
                                  : ColorGroup.modalSBtnBGC,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(problemTitleController.sorttitle.toString()),
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
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
                                id: scrollController.problemList[index].id
                                    .toString(),
                                sector: scrollController
                                    .problemList[index].sector
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
                                isHoney: scrollController
                                        .problemList[index].isHoney ??
                                    false,
                                solutionCount: scrollController
                                    .problemList[index].solutionCount
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
          const SizedBox(
            width: 100,
          ),
          ProblemFilter(),
        ],
      ),
    );
  }
}
