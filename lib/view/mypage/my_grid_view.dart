import 'package:flash/controller/dio/my_gridview_controller.dart';
import 'package:flash/view/mypage/my_grid_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyGridView extends StatelessWidget {
  final String profileUrl;
  MyGridView({
    super.key,
    required this.profileUrl,
  });
  MyGridviewController myGridviewController = Get.put(MyGridviewController());
  @override
  Widget build(BuildContext context) {
    myGridviewController.newFetch();
    return Obx(
      () {
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 그리드 열 수
            childAspectRatio: 0.7, // 카드의 종횡비
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: myGridviewController.solutionList.length,
          itemBuilder: (context, index) {
            return MyVideoCard(
              solutionId: myGridviewController.solutionList[index].solutionId!,
              gymName:
                  myGridviewController.solutionList[index].gymName.toString(),
              sectorName: myGridviewController.solutionList[index].sectorName
                  .toString(),
              difficultyName: myGridviewController
                  .solutionList[index].difficultyName
                  .toString(),
              problemImageUrl: myGridviewController
                  .solutionList[index].thumbnailImageUrl
                  .toString(),
              uploadedAt: myGridviewController.solutionList[index].solvedDate
                  .toString(),
              profileUrl: profileUrl,
            );
          },
        );
      },
    );
  }
}
