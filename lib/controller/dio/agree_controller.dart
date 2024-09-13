import 'package:dio/dio.dart';
import 'package:flash/const/data.dart';

import 'dio_singletone.dart';

class AgreeController {
  void agreeMarketing(bool hasAgreedToMarketing) async {
    try {
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());

      await DioClient().dio.post(
            "/members/marketing-consent",
            data: {
              "hasAgreedToMarketing": hasAgreedToMarketing,
            },
            options: Options(
              headers: {
                'Content-Type': 'application/json',
              },
            ),
          );
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('agree DioError: ${e.response?.headers}');
          print('Error Response Data: ${e.response?.data}');
        } else {
          print('Error: ${e.message}');
        }
      }
    }
  }
}
