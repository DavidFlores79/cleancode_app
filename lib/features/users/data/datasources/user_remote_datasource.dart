import 'package:dio/dio.dart';
import 'package:cleancode_app/core/config/api_config.dart';
import 'package:cleancode_app/core/network/dio_client.dart';
import 'package:cleancode_app/features/users/data/models/user_model.dart';
abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final DioClient dioClient;

  UserRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<UserModel>> getUsers() async {
  
    try {
      final response = await dioClient.dio.get(ApiConfig.usersEndpoint);

      if (response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((json) => UserModel.fromMap(json))
            .toList();
      } else {
        throw Exception('Failed to get users');
      }
    } on DioException catch (e) {
      String message = '${e.message ?? 'Error Desconocido'} ${(e.response?.statusCode == 403) ? e.response?.statusCode: ''}';
      throw Exception(message);
    }
  }
}