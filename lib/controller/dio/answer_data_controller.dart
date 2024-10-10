import 'package:dio/dio.dart';
import 'package:flash/const/data.dart';
import 'package:flash/controller/answer_carousel_controller.dart';
import 'package:flash/model/problem_detail_model.dart';
import 'package:flash/model/solution_model.dart';
import 'package:flash/view/answers/answer_card.dart';
import 'package:flash/view/answers/problem_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dios;
import 'package:video_player/video_player.dart';
import 'dio_singletone.dart';

class AnswerDataController extends GetxController {
  var answerList = <Widget>[].obs;
  String difficulty = '';
  String sector = '';
  List<VideoPlayerController?> videoControllerList = [];

  final AnswerCarouselController answerCarouselController =
      AnswerCarouselController();

  Future<void> fetchData(String problemId) async {
    dios.Response response;
    answerList.clear();
    try {
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());

      //문제 디테일 페이지 정보 요청
      response = await DioClient().dio.get(
            "/problems/$problemId",
          );
      Map<String, dynamic> resMap = Map<String, dynamic>.from(response.data);
      ProblemDetailModel detailInfo = ProblemDetailModel.fromJson(resMap);

      //analytics용
      difficulty = detailInfo.difficulty!;
      sector = detailInfo.sector!;
      final guide = await storage.read(key: GESTURE_GUIDE);
      answerList.add(
        ProblemDetailCard(
          problemId: problemId,
          gymName: detailInfo.gymName!,
          sector: detailInfo.sector!,
          difficulty: detailInfo.difficulty!,
          settingDate: detailInfo.settingDate!,
          removalDate: detailInfo.removalDate!,
          imgUrl: detailInfo.imageUrl!,
          hasSolution: detailInfo.hasSolution!,
          imageSource: detailInfo.imageSource ?? 'theclimb_life',
          guide: guide ?? 'NULL',
        ),
      );

      //answerList.add(const AnswerCard());
    } catch (e) {
      print('디테일 문제 로딩 실패$e');
    }
    try {
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());
      response = await DioClient().dio.get(
            "/problems/$problemId/solutions",
          );

      List<Map<String, dynamic>> resMapList =
          List<Map<String, dynamic>>.from(response.data["solutions"]);
      List<SolutionModel> sm =
          resMapList.map((e) => SolutionModel.fromJson(e)).toList();
      videoControllerList = List.generate(sm.length, (index) => null);

      List<Widget> solutionVideoList = sm.asMap().entries.map(
        (entry) {
          videoControllerList[entry.key] = VideoPlayerController.networkUrl(
            Uri.parse(entry.value.videoUrl!),
          );
          print(entry.value.profileImageUrl);
          return AnswerCard(
            videoController: videoControllerList[entry.key]!,
            uploader: entry.value.uploader ?? '',
            review: entry.value.review ?? '',
            instagramId: entry.value.instagramId ?? '',
            videoUrl: entry.value.videoUrl ?? '',
            solutionId: entry.value.id ?? 0,
            problemId: problemId,
            uploaderId: entry.value.uploaderId ?? '',
            isUploader: entry.value.isUploader ?? false,
            profileUrl: entry.value.profileImageUrl ?? '',
          );
        },
      ).toList();
      print("답지 적용 개수 ${solutionVideoList.length}");
      answerList.addAll(solutionVideoList);
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('해설 데이터 로딩 실패DioError: ${e.response?.statusCode}');
          print('Error Response Data: ${e.response?.data}');
        } else {
          print('Error: ${e.message}');
        }
      }
    }
  }

  Future<void> disposeVideo() async {
    //비디오 컨트롤러에 저장된 영상 해제
    for (var controller in videoControllerList) {
      controller?.dispose();
    }
  }
}
