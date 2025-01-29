import 'package:cleancode_app/core/errors/api_error.dart';
import 'package:cleancode_app/core/errors/api_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Si la respuesta del backend existe y tiene datos...
    if (err.type != DioExceptionType.unknown || err.type == DioExceptionType.connectionError) {
      // debugPrint("==== ${err.type}");
      // debugPrint("==== ${err.response?.statusCode}");
      try {
        // Intentamos parsear la respuesta en nuestro formato de error estandarizado.
        // debugPrint("==== ${err.response?.data}");
        final apiError = ApiError.fromJson(err.response!.data);
        // Lanza una excepción personalizada con el error estandarizado.
        throw ApiException(apiError, err.response?.statusCode ?? 500);
      } on ApiException catch (e) {
        throw ApiException(ApiError(message: e.apiError.message),err.response?.statusCode ?? 500,);
      } catch (e) {
        // Si hay algún error en el parseo, lanzamos una excepción genérica.
        throw ApiException(ApiError(message: 'Error al procesar la respuesta del servidor.'),err.response?.statusCode ?? 500,);
      }
    } else {
      // En caso de que no tengamos respuesta, mandamos un error generico.
      // throw ApiException(ApiError(message: 'Error de conexión'), err.response?.statusCode ?? 500);
    }

    super.onError(err, handler);
  }
}