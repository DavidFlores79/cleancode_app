import 'package:cleancode_app/core/domain/entities/auth_response.dart';
import 'package:dio/dio.dart';
import 'package:cleancode_app/core/config/api_config.dart';
import 'package:cleancode_app/core/network/dio_client.dart';
import 'package:cleancode_app/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponse> login(String email, String password);
  Future<AuthUserModel> register(String name, String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<AuthResponse> login(String email, String password) async {
    try {
      final response = await dioClient.dio.post(ApiConfig.loginEndpoint, data: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        final data = response.data;
        return AuthResponse.fromMap(data);
      } else {
        throw Exception('Failed to login');
      }
    } on DioException catch(e) {
      throw Exception(e.response!.data['message']);
    }
    catch (e) {
        throw Exception(e.toString());
    }
  }

    @override
  Future<AuthUserModel> register(String name, String email, String password) async {
    try {
      final response = await dioClient.dio.post(ApiConfig.registerEndpoint, data: {'name': name, 'email': email, 'password': password});
      if (response.statusCode == 200) {
        return AuthUserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to register');
      }
    } on DioException catch(e) {
       throw Exception(e);
    }
    catch (e) {
        throw Exception(e.toString());
    }
  }
}