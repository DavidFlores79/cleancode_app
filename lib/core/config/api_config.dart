class ApiConfig {
  static const String baseUrl = 'http://localhost:3001'; // Reemplaza con la URL de tu API
  // static const String baseUrl = 'https://congreso-backend-production.up.railway.app'; // Reemplaza con la URL de tu API
  static const String loginEndpoint = "${ApiConfig.baseUrl}/auth/login";
  static const String registerEndpoint = '${ApiConfig.baseUrl}/auth/register';
  static const String productsEndpoint = '${ApiConfig.baseUrl}/api/posters';
  static const String rolesEndpoint = '${ApiConfig.baseUrl}/api/roles';
  static const String usersEndpoint = '${ApiConfig.baseUrl}/api/users';
  static String modulesEndpoint(String profileId) {
    return '${ApiConfig.baseUrl}/api/profiles/$profileId/menu';
  }

}