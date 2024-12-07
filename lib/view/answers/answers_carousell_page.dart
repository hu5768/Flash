import 'package:flash/controller/dio/answer_data_controller.dart';
import 'package:flash/controller/dio/center_title_controller.dart';
import 'package:flash/controller/dio/first_answer_controller.dart';
import 'package:flash/controller/problem_filter_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/upload/answer_upload.dart';
import 'package:flash/view/upload/next_answer_upload.dart';
import 'package:get/get.dart';
import 'package:flash/controller/answer_carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flash/const/Colors/color_group.dart';
import 'package:flutter/material.dart';

class AnswersCarousell extends StatelessWidget {
  final String gymName, id, difficulty, sector, holdColorCode;
  final answerCarouselController = Get.put(AnswerCarouselController());
  final answerDataController = Get.put(AnswerDataController());
  final firstAnswerController = Get.put(FirstAnswerController());

  final bool hasSolution;
  AnswersCarousell({
    super.key,
    required this.gymName,
    required this.id,
    required this.hasSolution,
    required this.difficulty,
    required this.sector,
    required this.holdColorCode,
  });
  @override
  Widget build(BuildContext context) {
    AnalyticsService.screenView('SolutionPage', '');
    answerCarouselController.cIndex.value = 0;

    return PopScope(
      onPopInvokedWithResult: (bool a, result) async {
        answerDataController.disposeVideo();
        print('비디오 컨트롤러 해제');
      },
      child: Scaffold(
        backgroundColor: ColorGroup.BGC,
        body: SafeArea(
          child: Center(
            child: Container(
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Positioned(
                    child: GetX<AnswerDataController>(
                      builder: (controller) {
                        return CarouselSlider(
                          carouselController:
                              answerCarouselController.carouselSliderController,
                          items: answerDataController.answerList,
                          options: CarouselOptions(
                            enableInfiniteScroll: false,
                            height: double.infinity,
                            viewportFraction: 1.0,
                            onPageChanged: (index, reason) {
                              AnalyticsService.buttonClick(
                                'AnswerCarouselSlide',
                                answerDataController.sector,
                                gymName,
                                answerDataController.difficulty,
                              );

                              if (0 <=
                                      answerCarouselController.cIndex.value -
                                          1 &&
                                  answerCarouselController.cIndex.value - 1 <
                                      answerDataController
                                          .videoControllerList.length)
                                answerDataController.videoControllerList[
                                        answerCarouselController.cIndex.value -
                                            1]!
                                    .pause();

                              if (reason == CarouselPageChangedReason.manual)
                                answerCarouselController.cIndex.value = index;

                              if (0 <= index - 1 &&
                                  index - 1 <
                                      answerDataController
                                          .videoControllerList.length) {
                                answerDataController
                                    .videoControllerList[index - 1]!
                                    .play();
                                //print('영상 실행');
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.9),
                            Colors.black.withOpacity(0.6),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    //인디케이터
                    top: 10,
                    child: CarouselIndicator(
                      answerDataController: answerDataController,
                      answerCarouselController: answerCarouselController,
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 24,
                    right: 24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CloseButton(),
                        TextButton(
                          onPressed: () async {
                            AnalyticsService.buttonClick(
                              'upload',
                              hasSolution.toString(),
                              gymName,
                              difficulty,
                            );
                            firstAnswerController.NextiInitUpload(
                              holdColorCode,
                              difficulty,
                              sector,
                            );
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NextAnswerUpload(
                                  problemId: id,
                                  gymName: gymName,
                                  difficulty: difficulty,
                                  sector: sector,
                                  holdColorcode: holdColorCode,
                                ),
                              ),
                            );
                            await answerDataController.disposeVideo();
                            answerDataController.fetchData(id);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.upload,
                                size: 32,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '내 풀이 업로드',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
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
            ),
          ),
        ),
      ),
    );
  }
}

class CloseButton extends StatelessWidget {
  const CloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
        size: 32,
      ),
    );
  }
}

class CarouselIndicator extends StatelessWidget {
  const CarouselIndicator({
    super.key,
    required this.answerDataController,
    required this.answerCarouselController,
  });

  final AnswerDataController answerDataController;
  final AnswerCarouselController answerCarouselController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Obx(
        () {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
                answerDataController.answerList.asMap().entries.map((entry) {
              double indicatorSize = MediaQuery.of(context).size.width /
                      answerDataController.answerList.length -
                  20;
              return Container(
                width: indicatorSize > 10 ? indicatorSize : 10,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: entry.key == answerCarouselController.cIndex.value
                      ? const Color.fromARGB(255, 255, 255, 255)
                      : const Color.fromARGB(255, 194, 194, 194)
                          .withOpacity(0.5),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
