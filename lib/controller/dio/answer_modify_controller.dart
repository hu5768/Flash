import 'package:dio/dio.dart';
import 'package:flash/const/data.dart';
import 'package:flash/controller/dio/dio_singletone.dart';
import 'package:get/get.dart';

class AnswerModifyController extends GetxController {
  var difficultyLabel = '보통'.obs;

  Future<void> userReviewFetch(
    String videoUrl,
    String review,
    int solutionId,
  ) async {
    final data = {
      "videoUrl": videoUrl,
      "review": review,
    };

    try {
      // PATCH 요청
      print('유저 정보 Patch');
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());
      final response =
          await DioClient().dio.patch('/solutions/${solutionId}', data: data);

      if (response.statusCode == 200) {
        // 요청이 성공적으로 처리된 경우
        print('Member information updated successfully');
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
}
