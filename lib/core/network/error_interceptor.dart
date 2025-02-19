import 'package:cleancode_app/core/errors/api_error.dart';
import 'package:cleancode_app/core/errors/api_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Si la respuesta del backend existe y tiene datos...
    if (err.type != DioExceptionType.unknown || err.type == DioExceptionType.connectionError) {
      try {
        debugPrint("paso 1");
        // Intentamos parsear la respuesta en nuestro formato de error estandarizado.
        final apiError = ApiError.fromJson(err.response!.data);
        // Lanza una excepción personalizada con el error estandarizado.
        throw ApiException(apiError, err.response?.statusCode ?? 500);
      } on ApiException catch (e) {
        debugPrint("paso 1a");
        throw DioException(response: err.response, requestOptions: err.requestOptions, message: e.apiError.message);
      } catch (e) {
        debugPrint("paso 1b");
        debugPrint("${err.response?.statusCode}");
        // Si hay algún error en el parseo, lanzamos una excepción genérica.
        throw DioException(requestOptions: err.requestOptions, message: "Error desconocido (111) ${err.message}");
      }
    } else {
      // En caso de que no tengamos respuesta, mandamos un error generico.
      // throw ApiException(ApiError(message: 'Error de conexión'), err.response?.statusCode ?? 500);
    }

    super.onError(err, handler);
  }
}