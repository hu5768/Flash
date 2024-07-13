import 'package:dio/dio.dart';

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
        baseUrl:
            'http://flash-application-dev-env.eba-q2es2zy8.ap-northeast-2.elasticbeanstalk.com',
        connectTimeout: const Duration(milliseconds: 10000),
        receiveTimeout: const Duration(milliseconds: 10000),
      ),
    );
  }

  Dio get dio => _dio;
}
