import 'package:dio/dio.dart';

class DioClient {
  late Dio _dio;
  final String baseUrl = "https://api.climbing-answer.com";
  final String baseUrlDev = "http://15.165.90.192";
  static final DioClient _instance = DioClient._internal();

  factory DioClient() {
    return _instance;
  }
//http://flash-application-dev-env.eba-q2es2zy8.ap-northeast-2.elasticbeanstalk.com
  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(milliseconds: 10000),
        receiveTimeout: const Duration(milliseconds: 10000),
      ),
    );
  }

  Dio get dio => _dio;
}
