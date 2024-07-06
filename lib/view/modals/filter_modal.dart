import 'package:flash/controller/problem_filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterModal extends StatelessWidget {
  final ProblemFilterController problemFilterController = Get.find();

  FilterModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
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
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                    CheckboxListTile(
                      title: const Center(
                        child: Text(
                          '아무도 못 푼 문제 풀기',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      value: false,
                      onChanged: (bool? value) {
                        problemFilterController.checkBoxToggle();
                      },
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
                        () => problemFilterController.allEmpty()
                            ? const SizedBox()
                            : ElevatedButton(
                                onPressed: () {
                                  problemFilterController.goEmpty();
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(100, 50),
                                  side: const BorderSide(
                                    color: Color.fromRGBO(53, 113, 220, 1),
                                  ),
                                  foregroundColor:
                                      const Color.fromRGBO(53, 113, 220, 1),
                                  backgroundColor:
                                      const Color.fromRGBO(243, 248, 254, 1),
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
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(250, 50),
                          foregroundColor: Colors.white,
                          backgroundColor:
                              const Color.fromRGBO(53, 113, 220, 1),
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
    );
  }
}

class FilterTab extends StatelessWidget {
  const FilterTab({
    super.key,
    required this.problemFilterController,
    required this.index,
    required this.title,
  });
  final int index;
  final String title;
  final ProblemFilterController problemFilterController;

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
                      style: isSelected
                          ? const TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(53, 113, 220, 1),
                            )
                          : const TextStyle(fontSize: 20),
                    ),
                    selectedColor: const Color.fromRGBO(243, 248, 254, 1),
                    backgroundColor: Colors.white,
                    side: isSelected
                        ? const BorderSide(
                            color: Color.fromRGBO(53, 113, 220, 1),
                          )
                        : const BorderSide(
                            color: Color.fromRGBO(158, 158, 163, 1),
                          ),
                    selected: isSelected,
                    onSelected: (bool selected) {
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
