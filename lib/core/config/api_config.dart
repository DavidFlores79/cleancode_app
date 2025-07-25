import 'package:flutter/foundation.dart';

class ApiConfig {
  static const String debugBaseUrl =
      'http://192.168.100.45:3001'; // Reemplaza con la URL de tu API
  static const String productionBaseUrl =
      'https://congreso-backend-production.up.railway.app'; // Reemplaza con la URL de tu API
  static const String baseUrl = kReleaseMode
      ? productionBaseUrl
      : debugBaseUrl; // Reemplaza con la URL de tu API
  static const String loginEndpoint = "${ApiConfig.baseUrl}/auth/login";
  static const String registerEndpoint = '${ApiConfig.baseUrl}/auth/register';
  static const String productsEndpoint = '${ApiConfig.baseUrl}/api/posters';
  static const String categoriesEndpoint =
      '${ApiConfig.baseUrl}/api/categories';
  static const String paymentMethodsEndpoint =
      '${ApiConfig.baseUrl}/api/payment-methods';
  static const String paymentsEndpoint = '${ApiConfig.baseUrl}/api/payments';
  static const String summariesEndpoint = '${ApiConfig.baseUrl}/api/summaries';
  static const String postersEndpoint = '${ApiConfig.baseUrl}/api/posters';
  static const String rolesEndpoint = '${ApiConfig.baseUrl}/api/roles';
  static const String usersEndpoint = '${ApiConfig.baseUrl}/api/users';
  static const String searchEndpoint = '${ApiConfig.baseUrl}/api/search';
  static String modulesEndpoint(String profileId) {
    return '${ApiConfig.baseUrl}/api/profiles/$profileId/menu';
  }
}
