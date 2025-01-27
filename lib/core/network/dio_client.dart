import 'package:cleancode_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:cleancode_app/core/config/api_config.dart';
import 'package:dio/dio.dart';
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
    void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
        final authRepository = GetIt.I<AuthRepository>();
         final token = await authRepository.getToken();
        if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
        }
        super.onRequest(options, handler);
    }
}