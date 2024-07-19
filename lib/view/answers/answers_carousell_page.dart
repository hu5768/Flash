import 'package:flash/controller/answer_data_controller.dart';
import 'package:flash/firebase/firebase_event_button.dart';
import 'package:flash/view/answers/wrong_answer.dart';
import 'package:get/get.dart';
import 'package:flash/controller/answer_carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flash/const/Colors/color_group.dart';
import 'package:flutter/material.dart';

class AnswersCarousell extends StatelessWidget {
  final String id;
  final answerCarouselController = Get.put(AnswerCarouselController());
  final answerDataController = Get.put(AnswerDataController());
  AnswersCarousell({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    answerDataController.fetchData(id);
    answerCarouselController.cIndex.value = 0;

    return Scaffold(
      backgroundColor: ColorGroup.BGC,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            AnalyticsService.sendAnswerButtonEvent('close_answerList_button');
            Navigator.pop(context);
          },
        ),
        backgroundColor: ColorGroup.appbarBGC,
        title: SizedBox(
          height: AppBar().preferredSize.height,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '더클라임 강남',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              SizedBox(
                width: 80,
              ),
            ],
          ),
        ),
      ),
      body: true
          ? Center(
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: 400), //이 사이부분 빌드 시 오류남
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Positioned(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: GetX<AnswerDataController>(
                            builder: (controller) {
                              return CarouselSlider(
                                items: answerDataController.answerList,
                                options: CarouselOptions(
                                  //enlargeCenterPage: true,
                                  enableInfiniteScroll: false,
                                  height: double.infinity,
                                  viewportFraction: 1.0,
                                  onPageChanged: (index, reason) {
                                    answerCarouselController.cIndex.value =
                                        index;
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        //인디케이터
                        bottom: 15,
                        child: SizedBox(
                          width: 100 +
                              8 *
                                  answerDataController.answerList.length
                                      .toDouble(),
                          child: Obx(
                            () {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: answerDataController.answerList
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  return Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: entry.key ==
                                              answerCarouselController
                                                  .cIndex.value
                                          ? ColorGroup.selectBtnBGC
                                          : ColorGroup.modalBtnBGC,
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : const WrongAnswer(),
    );
  }
}
