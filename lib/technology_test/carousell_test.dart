import 'package:carousel_slider/carousel_slider.dart';
import 'package:flash/view/problem/problem_card.dart';
import 'package:flutter/material.dart';

class CarousellTest extends StatelessWidget {
  CarousellTest({super.key});
  final List textN = ["더클라임 양재", "더클라임 강남", "더클더클"];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: textN.map(
        (tlist) {
          return Builder(
            builder: (context) {
              return Column(
                children: [
                  const ProblemCard(
                    sector: '동작',
                  ),
                  Text(tlist)
                ],
              );
            },
          );
        },
      ).toList(),
      options: CarouselOptions(
        height: double.infinity,
        viewportFraction: 0.9,
      ),
    );
  }
}
