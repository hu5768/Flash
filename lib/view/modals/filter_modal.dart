import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/center_title_controller.dart';
import 'package:flash/controller/problem_filter_controller.dart';
import 'package:flash/controller/problem_list_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterModal extends StatelessWidget {
  final ProblemFilterController problemFilterController = Get.find();
  final ProblemListController problemListController = Get.find();
  final CenterTitleController centerTitleController = Get.find();
  FilterModal({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8, //자식 위젯의 크기 받아오는거 함 찾아봐야 됨
      minChildSize: 0.7,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            color: ColorGroup.BGC,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    const Text(
                      "문제 필터링",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
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
                                AnalyticsService.modalClick(
                                  '못푼 문제 보기',
                                  centerTitleController.centerTitle.string,
                                  problemFilterController.allTempSelection[0]
                                      .toString(),
                                  problemFilterController.allTempSelection[1]
                                      .toString(),
                                  problemFilterController.nobodySolTemp.value
                                      .toString(),
                                );
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
                                  AnalyticsService.modalClick(
                                    '초기화',
                                    centerTitleController.centerTitle.string,
                                    problemFilterController.allTempSelection[0]
                                        .toString(),
                                    problemFilterController.allTempSelection[1]
                                        .toString(),
                                    problemFilterController.nobodySolTemp.value
                                        .toString(),
                                  );
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
                                AnalyticsService.modalClick(
                                  '적용하기',
                                  centerTitleController.centerTitle.string,
                                  problemFilterController.allTempSelection[0]
                                      .toString(),
                                  problemFilterController.allTempSelection[1]
                                      .toString(),
                                  problemFilterController.nobodySolTemp.value
                                      .toString(),
                                );
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
        );
      },
    );
  }
}

class FilterTab extends StatelessWidget {
  FilterTab({
    super.key,
    required this.problemFilterController,
    required this.index,
    required this.title,
  });
  final int index;
  final String title;
  final ProblemFilterController problemFilterController;
  final CenterTitleController centerTitleController = Get.find(); //analytics
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Obx(
          () {
            return Wrap(
              spacing: 24,
              runSpacing: 20,
              children: problemFilterController.allOption[index].map(
                (option) {
                  final isSelected = problemFilterController
                      .allTempSelection[index]
                      .contains(option);
                  return FilterChip(
                    showCheckmark: false,
                    label: Text(
                      option,
                      style: TextStyle(
                        fontSize: 20,
                        color: isSelected
                            ? ColorGroup.selectBtnBGC
                            : ColorGroup.btnFGC,
                      ),
                    ),
                    selectedColor: ColorGroup.modalSBtnBGC,
                    backgroundColor: ColorGroup.btnBGC,
                    side: BorderSide(
                      color: isSelected
                          ? ColorGroup.selectBtnBGC
                          : ColorGroup.modalBtnBGC,
                    ),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      AnalyticsService.modalClick(
                        title,
                        centerTitleController.centerTitle.string,
                        problemFilterController.allTempSelection[0].toString(),
                        problemFilterController.allTempSelection[1].toString(),
                        problemFilterController.nobodySolTemp.value.toString(),
                      );
                      problemFilterController.toggleSelection(
                        option,
                        index,
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                  );
                },
              ).toList(),
            );
          },
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
