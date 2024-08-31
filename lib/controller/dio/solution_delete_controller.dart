import 'package:dio/dio.dart';
import 'package:flash/const/data.dart';

import 'dio_singletone.dart';

class SolutionDeleteController {
  void DeleteSolution(String problemId, int solutionId) async {
    try {
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());
      print("문제 id $solutionId");
      final response = await DioClient().dio.delete(
            "/problems/${problemId}/solutions/${solutionId}",
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
