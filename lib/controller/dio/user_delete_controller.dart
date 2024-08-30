import 'package:dio/dio.dart';
import 'package:flash/const/data.dart';

import 'dio_singletone.dart';

class UserDeleteController {
  void DeleteMember() async {
    try {
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());
      print("유저 삭제 시작");
      final response = await DioClient().dio.delete(
            "/members",
            options: Options(
              headers: {
                'Content-Type': 'application/json',
              },
            ),
          );
      print(response.data["nickName"] + '삭제');
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
