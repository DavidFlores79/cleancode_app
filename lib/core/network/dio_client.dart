import 'package:cleancode_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:cleancode_app/core/config/api_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  Dio get dio {
    _dio.interceptors.add(AuthInterceptor());
    return _dio;
  }
}

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final authRepository = GetIt.I<AuthRepository>();
    final token = await authRepository.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String message = 'xxx';
    debugPrint("${err.response?.data['msg']}");
    
    if("${err.response?.data['msg']}" != 'null'){
      message = "${err.response?.data?['msg']}";
    } else if("${err.response?.data?['errors']?[0]?['msg']}" != 'null') {
      message = "${err.response?.data?['errors']?[0]?['msg']}";
    }
    err.response!.data['message'] = message;
    super.onError(err, handler);
  }
}
