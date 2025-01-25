import 'package:dio/dio.dart';
import 'package:cleancode_app/core/config/api_config.dart';
import 'package:cleancode_app/core/network/dio_client.dart';
import 'package:cleancode_app/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String name, String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await dioClient.dio.post(ApiConfig.loginEndpoint, data: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to login');
      }
    } on DioException catch(e) {
      throw Exception(e.message);
    }
    catch (e) {
        throw Exception(e.toString());
    }
  }

    @override
  Future<UserModel> register(String name, String email, String password) async {
    try {
      final response = await dioClient.dio.post(ApiConfig.registerEndpoint, data: {'name': name, 'email': email, 'password': password});
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to register');
      }
    } on DioException catch(e) {
       throw Exception(e.message);
    }
    catch (e) {
        throw Exception(e.toString());
    }
  }
}