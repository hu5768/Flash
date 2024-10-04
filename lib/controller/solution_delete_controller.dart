import 'package:dio/dio.dart';
import 'package:flash/controller/login_controller.dart';

import 'dio_singletone.dart';

class SolutionDeleteController {
  Future<void> DeleteSolution(int solutionId) async {
    try {
      DioClient().updateOptions(token: LoginController.accessstoken);

      final response = await DioClient().dio.delete(
            "/solutions/$solutionId",
            options: Options(
              headers: {
                'Content-Type': 'application/json',
              },
            ),
          );
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
