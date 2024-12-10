import 'package:flash/const/Colors/center_color.dart';
import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/const/Colors/make_hold_color.dart';
import 'package:flash/controller/date_form.dart';
import 'package:flash/controller/dio/answer_data_controller.dart';
import 'package:flash/controller/dio/problem_list_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/answers/answers_carousell_page.dart';
import 'package:flash/view/problem/problem_card_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProblemCard extends StatelessWidget {
  final String gymName,
      id,
      sector,
      difficulty,
      settingDate,
      removalDate,
      imageUrl,
      holdColorCode;
  final int solutionCount;
  final bool hasSolution, isHoney;
  final answerDataController = Get.put(AnswerDataController());
  final problemListController = Get.put(ProblemListController());
  ProblemCard({
    super.key,
    required this.gymName,
    required this.id,
    required this.sector,
    required this.difficulty,
    required this.settingDate,
    required this.removalDate,
    required this.hasSolution,
    required this.imageUrl,
    required this.isHoney,
    required this.solutionCount,
    required this.holdColorCode,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (problemListController.isDoubleClick) return;
        problemListController.isDoubleClick = true;
        AnalyticsService.problemClick(
          id,
          difficulty,
          sector,
          hasSolution.toString(),
        );
        await answerDataController.fetchData(id);
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnswersCarousell(
              gymName: gymName,
              id: id,
              hasSolution: hasSolution,
              difficulty: difficulty,
              sector: sector,
              holdColorCode: holdColorCode,
            ),
            allowSnapshotting: true,
          ),
        );
        problemListController.isDoubleClick = false;
      },
      child: ProblemCardStyle(
        sector: sector,
        difficulty: difficulty,
        settingDate: settingDate,
        hasSolution: hasSolution,
        imageUrl: imageUrl,
        isHoney: isHoney,
        solutionCount: solutionCount,
        holdColorCode: holdColorCode,
      ),
    );
  }
}
