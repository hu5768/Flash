import 'package:dio/dio.dart';
import 'package:flash/const/data.dart';

import 'dio_singletone.dart';

class UserBlockController {
  void report(int solutionId) async {
    try {
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());
      print("문제 id $solutionId");
      final response = await DioClient().dio.post(
            "/members/reports/${solutionId}",
            data: {
              "reason": "신고함",
            },
            options: Options(
              headers: {
                'Content-Type': 'application/json',
              },
            ),
          );
      print(response.data);
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('DioError: ${e.response?.headers}');
          print('Error Response Data: ${e.response?.data}');
        } else {
          print('Error: ${e.message}');
        }
      }
    }
  }

  void block(String uploaderId) async {
    try {
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());
      print("사용자 id $uploaderId");
      final response = await DioClient().dio.post(
            "/members/blocks/${uploaderId}",
            data: {},
            options: Options(
              headers: {
                'Content-Type': 'application/json',
              },
            ),
          );
      print(response.data);
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('DioError: ${e.response?.headers}');
          print('Error Response Data: ${e.response?.data}');
        } else {
          print('Error: ${e.message}');
        }
      }
    }
  }
}
