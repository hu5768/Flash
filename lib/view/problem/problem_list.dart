import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/center_title_controller.dart';
import 'package:flash/controller/problem_filter_controller.dart';
import 'package:flash/controller/problem_list_controller.dart';
import 'package:flash/controller/problem_sort_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/modals/filter_modal.dart';
import 'package:flash/view/modals/sort_modal.dart';
import 'package:flash/view/problem/problem_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProblemList extends StatelessWidget {
  ProblemList({super.key});

  final problemTitleController = Get.put(ProblemSortController());
  final problemFilterController = Get.put(ProblemFilterController());
  final scrollController = Get.put(ProblemListController());
  final CenterTitleController centerTitleController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorGroup.BGC,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(
                    () => ElevatedButton(
                      onPressed: () {
                        AnalyticsService.sendMainButtonEvent(
                          'sort_button',
                          centerTitleController.centerTitle.toString(),
                        );
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
                  Obx(
                    () {
                      return ElevatedButton(
                        onPressed: () {
                          AnalyticsService.sendMainButtonEvent(
                            'filter_button',
                            centerTitleController.centerTitle.toString(),
                          );
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
                          foregroundColor: problemFilterController.allEmpty()
                              ? ColorGroup.btnFGC
                              : ColorGroup.selectBtnBGC,
                          backgroundColor: problemFilterController.allEmpty()
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
