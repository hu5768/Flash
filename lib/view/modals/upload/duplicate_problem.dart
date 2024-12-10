import 'package:flash/const/Colors/color_group.dart';
import 'package:flash/controller/dio/first_answer_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/problem/problem_card_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DuplicateProblem extends StatelessWidget {
  DuplicateProblem({super.key, required this.gymId});
  int gymId;
  bool isUploadClick = false;
  final firstAnswerController = Get.put(FirstAnswerController());
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // 둥근 모서리
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.white, // 팝업 배경색
          borderRadius: BorderRadius.circular(12), // 둥근 모서리
        ),
        padding: EdgeInsets.fromLTRB(24, 36, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '잠깐만요!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '동일한 문제의 답지가 있는 것 같습니다.\n해당 답지에 추가로 업로드 할까요?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: const Color.fromARGB(255, 17, 17, 17),
              ),
            ),
            SizedBox(height: 24),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 0.7,
              child: PageView(
                controller: firstAnswerController.duplicatePageController,
                children: firstAnswerController.duplicateList.map((problem) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProblemCardStyle(
                      sector: problem.sector!,
                      difficulty: problem.difficulty!,
                      settingDate: problem.settingDate!,
                      hasSolution: problem.hasSolution ?? false,
                      imageUrl: problem.imageUrl ?? '',
                      isHoney: problem.isHoney ?? false,
                      solutionCount: problem.solutionCount ?? 0,
                      holdColorCode: problem.holdColorCode ?? '#171717',
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 12),
            PageViewIndicator(),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  AnalyticsService.buttonClick(
                    'DuplicateUploadPage',
                    '중복문제에업로드',
                    '',
                    '',
                  );
                  if (isUploadClick) return;
                  isUploadClick = true; //더블터치 방지
                  firstAnswerController.isUpload = true;
                  await firstAnswerController.thumbImageUpload();
                  String duProblemId = firstAnswerController
                      .duplicateList[firstAnswerController.duplicatePage.value]
                      .id!;
                  firstAnswerController.nextUploadVideo(duProblemId);

                  Navigator.of(context).pop();
                  isUploadClick = false;
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(14, 14, 14, 14),
                  side: BorderSide(
                    width: 1,
                    color: const Color.fromARGB(
                      255,
                      196,
                      196,
                      196,
                    ),
                  ),
                  foregroundColor: const Color.fromARGB(255, 115, 115, 115),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
                child: Text(
                  '네, 추가로 업로드 할게요',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  AnalyticsService.buttonClick(
                    'DuplicateUploadPage',
                    '새로운문제에업로드',
                    '',
                    '',
                  );
                  if (isUploadClick) return;
                  isUploadClick = true; //더블터치 방지
                  firstAnswerController.isUpload = true;
                  await firstAnswerController.thumbImageUpload();
                  firstAnswerController.uploadVideo(gymId);
                  Navigator.of(context).pop(); // 팝업 닫기
                  isUploadClick = false;
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(14, 14, 14, 14),
                  side: BorderSide(
                    width: 1,
                    color: const Color.fromARGB(
                      255,
                      196,
                      196,
                      196,
                    ),
                  ),
                  foregroundColor: const Color.fromARGB(255, 115, 115, 115),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
                child: Text(
                  '아니요, 위 문제와 다른 문제입니다. ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  AnalyticsService.buttonClick(
                    'DuplicateUploadPage',
                    '닫기',
                    '',
                    '',
                  );
                  if (isUploadClick) return;
                  isUploadClick = true; //더블터치 방지
                  Navigator.of(context).pop(); // 팝업 닫기
                  isUploadClick = false;
                }, //padding: EdgeInsets.fromLTRB(14, 14, 14, 14),

                child: Text(
                  '닫기',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageViewIndicator extends StatelessWidget {
  PageViewIndicator({
    super.key,
  });

  final firstAnswerController = Get.put(FirstAnswerController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Obx(
        () {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: firstAnswerController.duplicateList
                .asMap()
                .entries
                .map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color:
                        entry.key == firstAnswerController.duplicatePage.value
                            ? const Color.fromARGB(255, 17, 17, 17)
                            : const Color.fromARGB(255, 196, 196, 196),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
