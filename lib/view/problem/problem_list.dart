import 'package:flash/controller/problem_filter_controller.dart';
import 'package:flash/controller/problem_sort_controller.dart';
import 'package:flash/view/modals/filter_modal.dart';
import 'package:flash/view/modals/sort_modal.dart';
import 'package:flash/view/problem/problem_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProblemList extends StatelessWidget {
  ProblemList({super.key});
  final problemTitleController = Get.put(ProblemSortController());
  final problemFilterController = Get.put(ProblemFilterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400, // 최대 너비 설정
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                        foregroundColor:
                            problemTitleController.sortkey.toString() == "none"
                                ? Colors.black
                                : Colors.white,
                        backgroundColor:
                            problemTitleController.sortkey.toString() == "none"
                                ? Colors.white
                                : Colors.brown[300],
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
                  ElevatedButton(
                    onPressed: () {
                      problemFilterController.inToTemp();
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return FilterModal();
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Text('필터'),
                        Icon(Icons.filter_list),
                      ],
                    ),
                  ),
                ],
              ),
              const ProblemCard(),
            ],
          ),
        ),
      ),
    );
  }
}
