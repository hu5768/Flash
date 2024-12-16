import 'package:flash/const/Colors/center_color.dart';
import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/center_title_controller.dart';
import 'package:flash/controller/first_answer_controller.dart';
import 'package:flash/controller/problem_list_controller.dart';
import 'package:flash/view/upload/admin_upload_new.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controller/problem_filter_controller.dart';

class ProblemFilter extends StatelessWidget {
  ProblemFilter({super.key});
  final ProblemFilterController problemFilterController = Get.find();
  final ProblemListController problemListController = Get.find();
  final CenterTitleController centerTitleController = Get.find();
  final firstAnswerController = Get.put(FirstAnswerController());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectorFilter(),
                  const SizedBox(height: 12),
                  GradeFilter(),
                  const SizedBox(height: 12),
                  ToggleFilter(),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      firstAnswerController.initUpload();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminUploadNew(
                            gymId: centerTitleController.centerId.value,
                          ),
                          allowSnapshotting: true,
                        ),
                      );
                    },
                    child: const Text('새로운 문제 업로드'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ToggleFilter extends StatelessWidget {
  ToggleFilter({
    super.key,
  });

  final ProblemFilterController problemFilterController = Get.find();
  final ProblemListController problemListController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text(
              '아무도 못푼 문제 ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Obx(
              () => Switch(
                inactiveTrackColor: ColorGroup.selectBtnFGC,
                activeTrackColor: ColorGroup.selectBtnBGC,
                value: problemFilterController.nobodySol.value,
                onChanged: (bool value) {
                  problemFilterController.nobodySol.value = value;
                  problemListController.FilterApply();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SectorFilter extends StatelessWidget {
  SectorFilter({
    super.key,
  });

  final ProblemFilterController problemFilterController = Get.find();
  final ProblemListController problemListController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          '섹터',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 20,
          child: VerticalDivider(
            color: Color.fromARGB(255, 196, 196, 196),
          ),
        ),
        SizedBox(
          height: 30,
          width: 300,
          child: Obx(
            () {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: problemFilterController.allOption[1].length,
                itemBuilder: (context, index) {
                  return Obx(
                    () {
                      final option =
                          problemFilterController.allOption[1][index];

                      final isSelected = problemFilterController.allSelection[1]
                          .contains(option);

                      return Container(
                        height: 30,
                        padding: const EdgeInsets.only(right: 12),
                        child: ChoiceChip(
                          selected: isSelected,
                          visualDensity: const VisualDensity(vertical: 0.0),
                          showCheckmark: false,
                          label: Align(
                            alignment: const Alignment(0, -1.2),
                            child: Text(
                              option,
                              style: TextStyle(
                                fontSize: 14,
                                color: isSelected
                                    ? Colors.white
                                    : const Color.fromARGB(255, 17, 17, 17),
                                height: 0,
                              ),
                            ),
                          ),
                          backgroundColor: Colors.white,
                          selectedColor: const Color.fromARGB(255, 0, 87, 255),
                          side: BorderSide(
                            color: isSelected
                                ? const Color.fromARGB(255, 0, 87, 255)
                                : const Color.fromARGB(255, 196, 196, 196),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                          ),
                          onSelected: (bool selected) {
                            problemFilterController.SectorSelection(option);
                            problemListController.FilterApply();
                          },
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class GradeFilter extends StatelessWidget {
  GradeFilter({
    super.key,
  });

  final ProblemFilterController problemFilterController = Get.find();
  final ProblemListController problemListController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          '난이도',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 20,
          child: VerticalDivider(
            color: Color.fromARGB(255, 196, 196, 196),
          ),
        ),
        SizedBox(
          height: 50,
          width: 300,
          child: Obx(
            () {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: problemFilterController.allOption[0].length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      problemFilterController.GradeSelection(
                        problemFilterController.allOption[0][index],
                      );
                      problemListController.FilterApply();
                    },
                    child: Container(
                      padding: const EdgeInsets.only(right: 12),
                      child: Obx(
                        () {
                          final option =
                              problemFilterController.allOption[0][index];
                          final isSelected = problemFilterController
                              .allSelection[0]
                              .contains(option);

                          return Stack(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 50,
                                color: CenterColor.TheClimbColorList[
                                    problemFilterController.allOption[0]
                                        [index]],
                              ),
                              if (isSelected)
                                Positioned(
                                  left: 4.835,
                                  top: 3.335,
                                  bottom: 3.335,
                                  child: SvgPicture.asset(
                                    'assets/images/select_color.svg',
                                    height: 40.33,
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
