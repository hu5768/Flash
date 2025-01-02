import 'dart:io';
import 'package:flash/const/data.dart';
import 'package:flash/const/uploadBaseUrl.dart';
import 'package:flash/const/date_form.dart';
import 'package:flash/controller/dio/dio_singletone.dart';
import 'package:flash/model/duplicate_problem_model.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData hide MultipartFile hide Response;
import 'package:video_player/video_player.dart';
import 'package:dio/dio.dart';

class FirstAnswerController extends GetxController {
  VideoPlayerController? videoController;
  File? selectVideo;
  File? thumbnailFile;
  String thumbnailImageUrl = '';
  bool fileLoad = false;

  List<String> HoldOption = []; // 홀드 색
  List<int> Holdid = [];
  int selectHoldId = 0;
  var selectHoldColor = ''.obs;

  List<String> gradeOption = []; // 난이도
  var selectGrade = ''.obs;

  List<String> sectorOption = []; //섹터
  var selectSector = ''.obs;
  List<String> sectorImageUrl = [];
  var sectorImageUrlString = ''.obs;
  int selectSectorId = 0;
  List<int> sectorIdList = [];

  var difficultyLabel = '보통이에요'.obs; //체감 난이도
  Map<String, String> diffName = {'꿀이에요': '쉬움', '보통이에요': '보통', '어려워요': '어려움'};
  Map<String, String> diffNameReverse = {
    '쉬움': '꿀이에요',
    '보통': '보통이에요',
    '어려움': '어려워요',
  };
  var selectDate = DateTime.now().obs; // 날짜

  final TextEditingController userOpinionText = TextEditingController(); //한줄평
  final userOpinionFocusNode = FocusNode();
  bool isUpload = false; //최종업로드 여부 업로드 팝업용
  var requiredSelect = false.obs; //필수선택 하면true

  List<DuplicateProblemModel> duplicateList = [];
  PageController duplicatePageController = PageController();
  var duplicatePage = 0.obs;
  void SectorSelection(String option, int index) {
    if (option == selectSector.value) {
      selectSector.value = '';
      sectorImageUrlString.value = '';
    } else {
      selectSector.value = option;
      sectorImageUrlString.value = sectorImageUrl[index];
    }
    selectSectorId = sectorIdList[index];
    requiredCheck();
    duplicatePageController.addListener(() {
      duplicatePage.value = duplicatePageController.page!.round();
    });
  }

  Future<void> initUpload() async {
    selectHoldColor.value = '';
    selectGrade.value = '';
    sectorImageUrlString.value = '';
    difficultyLabel.value = '보통이에요';
    selectDate.value = DateTime.now();
    selectSector.value = '';
    userOpinionText.text = '';
    requiredSelect.value = false;
    duplicatePage.value = 0;
    thumbnailFile = null;
  }

  Future<void> NextiInitUpload(
    String holdColorCode,
    String difficulty,
    String sector,
  ) async {
    selectHoldColor.value = holdColorCode; //
    selectGrade.value = difficulty; //
    sectorImageUrlString.value = findSectorUrl(sector); //
    difficultyLabel.value = '보통이에요';
    selectDate.value = DateTime.now();
    selectSector.value = sector; //
    userOpinionText.text = '';
    requiredSelect.value = false;
    thumbnailFile = null;
  }

  Future<void> initModify(
    String holdColorCode,
    String difficulty,
    String solvedDate,
    String perceivedDifficulty,
    String review,
    String thumbnailImageUrli,
  ) async {
    selectHoldColor.value = holdColorCode; //
    selectGrade.value = difficulty; //
    difficultyLabel.value = diffNameReverse[perceivedDifficulty]!;

    selectDate.value = DateTime.parse(solvedDate);
    userOpinionText.text = review;
    requiredSelect.value = true;
    thumbnailImageUrl = thumbnailImageUrli;
  }

  Future<void> userReviewFetch(
    String videoUrl,
    int solutionId,
  ) async {
    final data = {
      "videoUrl": videoUrl,
      "review": userOpinionText.text,
      'perceivedDifficulty': diffName[difficultyLabel.value],
      "thumbnailImageUrl": thumbnailImageUrl,
      "solvedDate": formatDateDate(selectDate.value),
    };
    try {
      // PATCH 요청
      print('해설수정 Patch');
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());
      final response =
          await DioClient().dio.patch('/solutions/${solutionId}', data: data);

      if (response.statusCode == 200) {
        // 요청이 성공적으로 처리된 경우
        print('solution updated successfully');
      } else {
        print('Failed to update member information: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('DioError: ${e.response?.statusCode}');
          print('Error Response Data: ${e.response?.data}');
        } else {
          print('Error: ${e.message}');
        }
      }
    }
  }

  String findSectorUrl(String sector) {
    String sectorImgUrl = '';
    int index = sectorOption.indexOf(sector);
    if (index != -1) {
      sectorImgUrl = sectorImageUrl[index];
      selectSectorId = index;
    } else
      sectorImgUrl = '';

    return sectorImgUrl;
  }

  Future<void> requiredCheck() async {
    bool tmp = true;
    tmp &= !(selectHoldColor.value == '');
    tmp &= !(selectGrade.value == '');
    tmp &= !(selectSector.value == '');
    tmp &= !(thumbnailFile == null);
    print(tmp);
    requiredSelect.value = tmp;
  }

  Future<void> thumbImageUpload() async {
    String fileName = '';
    fileName = basename(thumbnailFile!.path);

    Uint8List fileData = await File(thumbnailFile!.path).readAsBytes();
    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        thumbnailFile!.path,
        filename: fileName,
      ),
    });

    try {
      // PATCH 요청
      print('썸내일 이미지 업로드');
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());
      final response = await DioClient().dio.post(
            '${uploadServerUrl}images/',
            data: data,
            options: Options(
              headers: {
                "Content-Type": "multipart/form-data",
              },
            ),
          ); //이미지 업로드

      if (response.statusCode == 200) {
        // 요청이 성공적으로 처리된 경우
        thumbnailImageUrl = response.data["profileImageUrl"];
        print('response' + response.data.toString());
      } else {
        print('Failed to upload image: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('DioError: ${e.response?.statusCode}');
          print('Error Response Data: ${e.response?.data}');
        } else {
          print('Error: ${e.error}');
          print('Error: ${e.response}');
        }
      }
    }
  }

  Future<bool> duplicateCheck() async {
    bool duplicated = false;
    Response response;
    final token = await storage.read(key: ACCESS_TOKEN_KEY);
    DioClient().updateOptions(token: token.toString());

    try {
      print('문제 중복확인 get');
      response = await DioClient().dio.get(
            "/problems/duplicate?sectorId=${selectSectorId}&holdColorId=${selectHoldId}&difficulty=${selectGrade.value}",
          );
      print('중복체크!');
      print(response.data['problems']);
      List<Map<String, dynamic>> resMap =
          List<Map<String, dynamic>>.from(response.data["problems"]);
      duplicateList =
          resMap.map((e) => DuplicateProblemModel.fromJson(e)).toList();
      print(duplicateList);
      duplicated = duplicateList.length > 0;
    } on DioException catch (e) {
      print('중복체크오류$e');
      if (e.response != null) {
        print('DioError: ${e.response?.statusCode}');
        print('Error Response Data: ${e.response?.data}');
      } else {
        print('Error: ${e.message}');
      }
      print('오류 헤더${e.response?.headers}');
      print('오류 바디${e.response?.data}');
    }
    return duplicated;
  }

  Future<void> uploadVideo(int gymId) async {
    if (selectVideo == null) return;
    print('새로운 문제 업로드 시작');
    final token = await storage.read(key: ACCESS_TOKEN_KEY);
    DioClient().updateOptions(token: token.toString());
    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          selectVideo!.path,
          filename: 'solution.mp4', // 파일 이름 설정
        ),
        'thumbnailImageUrl': thumbnailImageUrl,
        'solvedDate': formatDateDate(selectDate.value),
        'difficulty': selectGrade.value,
        'sectorId': selectSectorId,
        'holdId': selectHoldId,
        'gymId': gymId,
        'review': userOpinionText.text,
        'perceivedDifficulty': diffName[difficultyLabel.value],
      });

      final apiResponse = await DioClient().dio.post(
            '${uploadServerUrl}videos/upload/new/',
            data: formData,
            options: Options(
              contentType: 'multipart/form-data',
            ),
          );
      if (apiResponse.statusCode == 200) {
        print("최종 업로드 완료!");
      }
      //  }
    } on DioException catch (e) {
      print('영상 업로드 오류$e');
      if (e.response != null) {
        print('DioError: ${e.response?.statusCode}');
        print('Error Response Data: ${e.response?.data}');
      } else {
        print('Error: ${e.message}');
      }
      print('오류 헤더${e.response?.headers}');
      print('오류 바디${e.response?.data}');
    }
  }

  Future<void> nextUploadVideo(String problemId) async {
    if (selectVideo == null) return;
    print('존재하는 문제 업로드 시작');
    final token = await storage.read(key: ACCESS_TOKEN_KEY);
    DioClient().updateOptions(token: token.toString());
    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          selectVideo!.path,
          filename: 'solution.mp4', // 파일 이름 설정
        ),
        'problemId': problemId,
        'thumbnailImageUrl': thumbnailImageUrl,
        'solvedDate': formatDateDate(selectDate.value),
        'review': userOpinionText.text,
        'perceivedDifficulty': diffName[difficultyLabel.value],
      });

      final apiResponse = await DioClient().dio.post(
            '${uploadServerUrl}videos/upload/',
            data: formData,
            options: Options(
              contentType: 'multipart/form-data',
            ),
          );
      if (apiResponse.statusCode == 200) {
        print("최종 업로드 완료!");
        print("thumbnailImageUrl ${thumbnailImageUrl}");
        print("solvedDate ${formatDateDate(selectDate.value)}");
        print("problem ${problemId}");
        print("review ${userOpinionText.text}");
        print("perceivedDifficulty ${diffName[difficultyLabel.value]}");
      }
      //  }
    } on DioException catch (e) {
      print('영상 업로드 오류$e');
      if (e.response != null) {
        print('DioError: ${e.response?.statusCode}');
        print('Error Response Data: ${e.response?.data}');
      } else {
        print('Error: ${e.message}');
      }
      print('오류 헤더${e.response?.headers}');
      print('오류 바디${e.response?.data}');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
