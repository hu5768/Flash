import 'package:dio/dio.dart';
import 'package:flash/const/base_url.dart';

class DioClient {
  late Dio _dio;

  static final DioClient _instance = DioClient._internal();

  factory DioClient() {
    return _instance;
  }
//http://flash-application-dev-env.eba-q2es2zy8.ap-northeast-2.elasticbeanstalk.com
  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: apiServerUrl,
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 30000),
        sendTimeout: const Duration(milliseconds: 30000),
      ),
    );
  }
  void updateOptions({required String token}) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  Dio get dio => _dio;
}
