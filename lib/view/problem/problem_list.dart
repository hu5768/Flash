import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/center_title_controller.dart';
import 'package:flash/controller/problem_filter_controller.dart';
import 'package:flash/controller/problem_list_controller.dart';
import 'package:flash/controller/problem_sort_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/answers/answers_carousell_page.dart';
import 'package:flash/view/modals/filter_modal.dart';
import 'package:flash/view/modals/sort_modal.dart';
import 'package:flash/view/problem/problem_card.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProblemList extends StatelessWidget {
  ProblemList({super.key});

  final problemTitleController = Get.put(ProblemSortController());
  final problemFilterController = Get.put(ProblemFilterController());
  final problemListController = Get.put(ProblemListController());
  final CenterTitleController centerTitleController = Get.find();
  final TextEditingController idCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorGroup.BGC,
      body: Center(
        child: Row(
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
                              color:
                                  problemTitleController.sortkey.toString() ==
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
                      Obx(
                        () {
                          return ElevatedButton(
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
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(115, 40),
                              side: BorderSide(
                                color: problemFilterController.allEmpty()
                                    ? ColorGroup.modalBtnBGC
                                    : ColorGroup.selectBtnBGC,
                              ),
                              foregroundColor:
                                  problemFilterController.allEmpty()
                                      ? ColorGroup.btnFGC
                                      : ColorGroup.selectBtnBGC,
                              backgroundColor:
                                  problemFilterController.allEmpty()
                                      ? ColorGroup.btnBGC
                                      : ColorGroup.modalSBtnBGC,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Row(
                              children: [
                                problemFilterController.allEmpty()
                                    ? const Text('필터')
                                    : Text(
                                        '필터${problemFilterController.countFilter()}',
                                      ),
                                const Icon(Icons.filter_alt_outlined),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GetX<ProblemListController>(
                    builder: (controller) {
                      return Expanded(
                        child: ListView.builder(
                          controller: problemListController.scrollController,
                          itemCount: problemListController.problemList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProblemCard(
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
            const SizedBox(width: 100),
            Container(
              width: 600,
              height: 600,
              color: ColorGroup.BGC,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FilterTab(
                          problemFilterController: problemFilterController,
                          index: 0,
                          title: "난이도",
                        ),
                        FilterTab(
                          problemFilterController: problemFilterController,
                          index: 1,
                          title: "섹터",
                        ),
                        Column(
                          children: [
                            const Divider(),
                            Obx(
                              () => CheckboxListTile(
                                title: const Center(
                                  child: Text(
                                    '아무도 못 푼 문제 보기',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                value:
                                    problemFilterController.nobodySolTemp.value,
                                onChanged: (bool? value) {
                                  problemFilterController.nobodySolTemp.value =
                                      value!;
                                  //  row와 checkbox로 새로 만들기
                                },
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 26, 0, 26.0),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Colors.grey,
                                width: 2.0, // 상단 테두리 두께
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Obx(
                                () => ElevatedButton(
                                  onPressed: () {
                                    problemFilterController.goEmpty();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(100, 50),
                                    side: BorderSide(
                                      color:
                                          problemFilterController.allTempEmpty()
                                              ? ColorGroup.modalBtnBGC
                                              : ColorGroup.selectBtnBGC,
                                    ),
                                    foregroundColor:
                                        problemFilterController.allTempEmpty()
                                            ? ColorGroup.btnFGC
                                            : ColorGroup.selectBtnBGC,
                                    backgroundColor:
                                        problemFilterController.allTempEmpty()
                                            ? ColorGroup.modalBGC
                                            : ColorGroup.modalSBtnBGC,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    "초기화",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  problemFilterController.tempToSel();
                                  problemListController.newFetch();
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(250, 50),
                                  foregroundColor: ColorGroup.selectBtnFGC,
                                  backgroundColor: ColorGroup.selectBtnBGC,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  "적용하기",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
