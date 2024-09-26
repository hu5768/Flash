import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/dio/center_title_controller.dart';
import 'package:flash/controller/problem_filter_controller.dart';
import 'package:flash/controller/dio/problem_list_controller.dart';
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
      initialChildSize: 0.65, //자식 위젯의 크기 받아오는거 함 찾아봐야 됨
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: ColorGroup.modalBGC,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        problemFilterController.goEmpty();
                      },
                      child: const Text(
                        "초기화",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorGroup.selectBtnBGC,
                        ),
                      ),
                    ),
                    const Text(
                      "문제 필터링",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '아무도 못 푼 문제 보기',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Obx(
                            () => Switch(
                              inactiveTrackColor: ColorGroup.selectBtnFGC,
                              activeTrackColor: ColorGroup.selectBtnBGC,
                              value:
                                  problemFilterController.nobodySolTemp.value,
                              onChanged: (bool value) {
                                AnalyticsService.buttonClick(
                                  'FilterModal',
                                  '아무도못푼문제보기',
                                  '',
                                  '',
                                );
                                problemFilterController.nobodySolTemp.value =
                                    value;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 35),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              AnalyticsService.buttonClick(
                                'FilterModal_apply',
                                problemFilterController.allTempSelection[1]
                                    .toString(),
                                '아무도 못푼문제' +
                                    problemFilterController.nobodySolTemp
                                        .toString(),
                                problemFilterController.allTempSelection[0]
                                    .toString(),
                              );
                              problemFilterController.tempToSel();
                              await problemListController.newFetch();
                              problemListController.ScrollUp();
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(250, 60),
                              foregroundColor: ColorGroup.selectBtnFGC,
                              backgroundColor: ColorGroup.selectBtnBGC,
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
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
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
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
                        fontSize: 17,
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
                      AnalyticsService.buttonClick(
                        'FilterModal',
                        option,
                        '',
                        '',
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
          height: 20,
        ),
      ],
    );
  }
}
