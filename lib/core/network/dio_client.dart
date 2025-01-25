import 'package:dio/dio.dart';
import 'package:cleancode_app/core/config/api_config.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  Dio get dio => _dio;
}