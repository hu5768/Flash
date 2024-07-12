import 'package:get/get.dart';
import 'package:flash/controller/answer_carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flash/Colors/color_group.dart';
import 'package:flash/view/answers/answer_card.dart';
import 'package:flutter/material.dart';

class AnswersCarousell extends StatelessWidget {
  final String sector;
  final answerCarouselController = Get.put(
    AnswerCarouselController(),
  );
  AnswersCarousell({
    super.key,
    required this.sector,
  });
  final List textN = ["더클라임 양재", "더클라임 강남", "더클더클"];
  @override
  @override
  Widget build(BuildContext context) {
    answerCarouselController.cIndex.value = 0;
    return Scaffold(
      backgroundColor: ColorGroup.BGC,
      appBar: AppBar(
        backgroundColor: ColorGroup.appbarBGC,
        title: Container(
          height: AppBar().preferredSize.height,
          decoration: const BoxDecoration(),
          child: Row(
            children: [
              const SizedBox(
                width: 120,
              ),
              Center(
                child: Text(
                  sector,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SizedBox.expand(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Positioned(
              child: SizedBox.expand(
                child: CarouselSlider(
                  items: textN.map(
                    (tlist) {
                      return Builder(
                        builder: (context) {
                          return const AnswerCard();
                        },
                      );
                    },
                  ).toList(),
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    height: double.infinity,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      answerCarouselController.cIndex.value = index;
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: SizedBox(
                width: 100,
                child: Obx(
                  () {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: textN.asMap().entries.map((entry) {
                        return Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: entry.key ==
                                    answerCarouselController.cIndex.value
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
    );
  }
}
