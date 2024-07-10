import 'package:dio/dio.dart';

class DioClient {
  late Dio _dio;
  static final DioClient _instance = DioClient._internal();

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com/posts',
        connectTimeout: const Duration(milliseconds: 10000),
        receiveTimeout: const Duration(milliseconds: 10000),
      ),
    );
  }

  Dio get dio => _dio;
}
