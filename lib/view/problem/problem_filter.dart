import 'package:flash/const/Colors/center_color.dart';
import 'package:flash/const/Colors/color_group.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/problem_filter_controller.dart';

class ProblemFilter extends StatelessWidget {
  ProblemFilter({super.key});
  final ProblemFilterController problemFilterController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 20),
          Image.asset('assets/images/gym_map.png'),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SectorFilter extends StatelessWidget {
  SectorFilter({
    super.key,
  });

  final ProblemFilterController problemFilterController = Get.find();

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
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: problemFilterController.allOption[1].length,
            itemBuilder: (context, index) {
              return Obx(
                () {
                  final option = problemFilterController.allOption[1][index];
                  final isSelected =
                      problemFilterController.allSelection[1].contains(option);

                  return Container(
                    height: 30,
                    padding: EdgeInsets.only(right: 12),
                    child: ChoiceChip(
                      selected: isSelected,
                      visualDensity: VisualDensity(vertical: 0.0),
                      showCheckmark: false,
                      label: Text(
                        option,
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 17, 17, 17),
                          height: 1,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      selectedColor: const Color.fromARGB(255, 0, 115, 255),
                      side: BorderSide(
                        color: const Color.fromARGB(255, 196, 196, 196),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          30,
                        ),
                      ),
                      onSelected: (bool selected) {
                        problemFilterController.SectorSelection(option);
                        print(option);
                        print(isSelected);
                      },
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

class GradeFilter extends StatelessWidget {
  GradeFilter({
    super.key,
  });

  final ProblemFilterController problemFilterController = Get.find();

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
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: problemFilterController.allOption[0].length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.circle,
                  size: 30,
                  color: CenterColor.TheClimbColorList[
                      problemFilterController.allOption[0][index]],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
