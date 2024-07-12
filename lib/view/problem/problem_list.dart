import 'package:flash/Colors/color_group.dart';
import 'package:flash/controller/fake_api_data.dart';
import 'package:flash/controller/problem_filter_controller.dart';
import 'package:flash/controller/problem_sort_controller.dart';
import 'package:flash/view/modals/filter_modal.dart';
import 'package:flash/view/modals/sort_modal.dart';
import 'package:flash/view/problem/problem_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProblemList extends StatelessWidget {
  ProblemList({super.key});
  final controller = Get.put(FakeController()); //임시 fake api
  final problemTitleController = Get.put(ProblemSortController());
  final problemFilterController = Get.put(ProblemFilterController());
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
                        print("순서버튼누름");
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return const SortModal();
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          color: problemTitleController.sortkey.toString() ==
                                  "none"
                              ? ColorGroup.modalBtnBGC
                              : ColorGroup.selectBtnBGC,
                        ),
                        foregroundColor:
                            problemTitleController.sortkey.toString() == "none"
                                ? ColorGroup.btnFGC
                                : ColorGroup.selectBtnBGC,
                        backgroundColor:
                            problemTitleController.sortkey.toString() == "none"
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
                          print("필터버튼누름");
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
              GetX<FakeController>(
                builder: (controller) {
                  return Expanded(
                    child: ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.FaCursor.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProblemCard(
                              sector: controller.FaCursor[index].id.toString(),
                            ),
                            const SizedBox(
                              height: 50,
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
