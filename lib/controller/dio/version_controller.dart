import 'package:dio/dio.dart';
import 'package:flash/controller/dio/dio_singletone.dart';

class VersionController {
  String androidVersion = '', iosVersion = '';

  Future<void> getVersion() async {
    try {
      final response = await DioClient().dio.get(
            "/versions",
          );
      print(response.data["android"] + '버전');
      print(response.data["ios"] + '버전');
      androidVersion = response.data["android"];
      iosVersion = response.data["ios"];
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
