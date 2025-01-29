import 'package:cleancode_app/core/errors/api_error.dart';

class ApiException implements Exception {
  final ApiError apiError;
  final int statusCode;

  ApiException(this.apiError, this.statusCode);

  @override
  String toString() {
    return '$apiError ($statusCode)';
  }
}