import 'package:flash/controller/center_sort_controller.dart';
import 'package:flash/view/modals/filter_modal.dart';
import 'package:flash/view/modals/sort_modal.dart';
import 'package:flash/view/problem/problem_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProblemList extends StatelessWidget {
  ProblemList({super.key});
  final centerTitleController = Get.put(CenterSortController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
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
                        centerTitleController.sortkey.toString() == "none"
                            ? Colors.black
                            : Colors.white,
                    backgroundColor:
                        centerTitleController.sortkey.toString() == "none"
                            ? Colors.white
                            : Colors.brown[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(centerTitleController.sorttitle.toString()),
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
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return const FilterModal();
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
          const ProblemCard(),
        ],
      ),
    );
  }
}
