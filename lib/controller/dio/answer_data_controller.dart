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
  List<VideoPlayerController?>? videoControllerList;
  final AnswerCarouselController answerCarouselController =
      AnswerCarouselController();

  void fetchData(String problemId) async {
    answerCarouselController.cIndex.value = 0;
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
      print("해설리스트 가져옴");
      List<Map<String, dynamic>> resMapList =
          List<Map<String, dynamic>>.from(response.data["solutions"]);
      List<SolutionModel> sm =
          resMapList.map((e) => SolutionModel.fromJson(e)).toList();
      videoControllerList = List.generate(sm.length, (index) => null);
      print(sm.length);
      List<Widget> solutionVideoList = sm.asMap().entries.map(
        (entry) {
          //바꾸면 오류나서 추후 수정

          videoControllerList![entry.key] = VideoPlayerController.networkUrl(
            Uri.parse(entry.value.videoUrl!),
          );

          return AnswerCard(
            videoController: videoControllerList![entry.key]!,
            uploader: entry.value.uploader ?? '',
            review: entry.value.review ?? '',
            instagramId: entry.value.instagramId ?? '',
            videoUrl: entry.value.videoUrl!,
            solutionId: entry.value.id!,
            problemId: problemId,
            uploaderId: entry.value.uploaderId!,
            isUploader: entry.value.isUploader!,
            profileUrl: entry.value.profileImageUrl ?? '',
          );
        },
      ).toList();
      print("캐러셀에 추가");
      answerList.addAll(solutionVideoList);
      print(answerList.length);
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
    if (videoControllerList != null)
      for (var controller in videoControllerList!) {
        controller?.dispose();
      }
  }
}
