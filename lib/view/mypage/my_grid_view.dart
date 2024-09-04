import 'package:flash/controller/dio/my_gridview_controller.dart';
import 'package:flash/view/mypage/my_video_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyGridView extends StatelessWidget {
  MyGridView({
    super.key,
  });
  MyGridviewController myGridviewController = Get.put(MyGridviewController());
  @override
  Widget build(BuildContext context) {
    myGridviewController.fetchData();
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
              index: myGridviewController.solutionList[index].instagramId
                  .toString(),
              videoUrl:
                  myGridviewController.solutionList[index].videoUrl.toString(),
              uploader:
                  myGridviewController.solutionList[index].uploader.toString(),
              instagramId: myGridviewController.solutionList[index].instagramId
                  .toString(),
              review:
                  myGridviewController.solutionList[index].review.toString(),
            );
          },
        );
      },
    );
  }
}
