class ApiConfig {
  static const String baseUrl = 'http://localhost:3001'; // Reemplaza con la URL de tu API
  static const String loginEndpoint = "${ApiConfig.baseUrl}/auth/login";
  static const String registerEndpoint = '${ApiConfig.baseUrl}/auth/register';
  static const String productsEndpoint = '${ApiConfig.baseUrl}/api/posters';
  static const String usersEndpoint = '${ApiConfig.baseUrl}/api/users';
}