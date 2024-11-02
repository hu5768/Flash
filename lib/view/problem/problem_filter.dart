import 'package:flash/const/Colors/center_color.dart';
import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/dio/center_title_controller.dart';
import 'package:flash/controller/dio/problem_list_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/problem/sort_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controller/problem_filter_controller.dart';

class ProblemFilter extends StatelessWidget {
  ProblemFilter({super.key});
  final ProblemFilterController problemFilterController = Get.find();
  final ProblemListController problemListController = Get.find();
  final CenterTitleController centerTitleController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 20),
          Obx(
            () {
              String mapImgUrl =
                  centerTitleController.centerDetailModel.value.mapImageUrl ??
                      "";
              print(mapImgUrl);
              return mapImgUrl != ''
                  ? SizedBox(
                      height: 112,
                      child: Image.network(
                        centerTitleController
                            .centerDetailModel.value.mapImageUrl!,
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox(
                            width: 350,
                            height: 350,
                            child: Text("지도를 불러오지 못했습니다."),
                          );
                        },
                      ),
                    )
                  : SizedBox();
            },
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.fromLTRB(24, 20, 24, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectorFilter(),
                  SizedBox(height: 12),
                  GradeFilter(),
                  SizedBox(height: 12),
                  ToggleFilter(),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SortMenuButton(),
              ],
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
            Text(
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
                  AnalyticsService.buttonClick(
                    'FilterModal_Toggle',
                    '풀이 없는 문제 필터 $value',
                    problemFilterController.allSelection[0].toString(),
                    problemFilterController.allSelection[1].toString(),
                  );
                  problemFilterController.nobodySol.value = value;
                  problemListController.FilterApply();
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              '꿀 문제 ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Obx(
              () => Switch(
                inactiveTrackColor: ColorGroup.selectBtnFGC,
                activeTrackColor: ColorGroup.selectBtnBGC,
                value: problemFilterController.isHoney.value,
                onChanged: (bool value) {
                  AnalyticsService.buttonClick(
                    'FilterModal_Toggle',
                    '꿀문제 필터 $value',
                    problemFilterController.allSelection[0].toString(),
                    problemFilterController.allSelection[1].toString(),
                  );
                  problemFilterController.isHoney.value = value;
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
        Text(
          '섹터',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 20,
          child: VerticalDivider(
            color: const Color.fromARGB(255, 196, 196, 196),
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
                        padding: EdgeInsets.only(right: 12),
                        child: ChoiceChip(
                          selected: isSelected,
                          visualDensity: VisualDensity(vertical: 0.0),
                          showCheckmark: false,
                          label: Align(
                            alignment: Alignment(0, -1.2),
                            child: Text(
                              option,
                              style: TextStyle(
                                fontSize: 14,
                                color: isSelected
                                    ? Colors.white
                                    : Color.fromARGB(255, 17, 17, 17),
                                height: 0,
                              ),
                            ),
                          ),
                          backgroundColor: Colors.white,
                          selectedColor: const Color.fromARGB(255, 0, 87, 255),
                          side: BorderSide(
                            color: isSelected
                                ? Color.fromARGB(255, 0, 87, 255)
                                : Color.fromARGB(255, 196, 196, 196),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                          ),
                          onSelected: (bool selected) {
                            AnalyticsService.buttonClick(
                              'FilterModal_Sector',
                              option,
                              problemFilterController.allSelection[0]
                                  .toString(),
                              '',
                            );
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
        Text(
          '난이도',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 20,
          child: VerticalDivider(
            color: const Color.fromARGB(255, 196, 196, 196),
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
                itemCount: problemFilterController.allOption[0].length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      AnalyticsService.buttonClick(
                        'FilterModal_Gade',
                        problemFilterController.allOption[0][index],
                        problemFilterController.allSelection[0].toString(),
                        '',
                      );
                      problemFilterController.GradeSelection(
                        problemFilterController.allOption[0][index],
                      );
                      problemListController.FilterApply();
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 12),
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
                                size: 30,
                                color: CenterColor.TheClimbColorList[
                                    problemFilterController.allOption[0]
                                        [index]],
                              ),
                              if (isSelected)
                                Positioned(
                                  left: 3.335,
                                  top: 3.335,
                                  bottom: 3.335,
                                  child: SvgPicture.asset(
                                    'assets/images/select_color.svg',
                                    height: 23.33,
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
