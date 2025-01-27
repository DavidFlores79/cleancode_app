import 'package:dio/dio.dart';
import 'package:cleancode_app/core/config/api_config.dart';
import 'package:cleancode_app/core/network/dio_client.dart';
import 'package:cleancode_app/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRemoteDataSource {
  Future<AuthUserModel> login(String email, String password);
  Future<AuthUserModel> register(String name, String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<AuthUserModel> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = await dioClient.dio.post(ApiConfig.loginEndpoint, data: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        final data = response.data;
        prefs.setString('token', data['jwt']);
        return AuthUserModel.fromMap(data['user']);
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
  Future<AuthUserModel> register(String name, String email, String password) async {
    try {
      final response = await dioClient.dio.post(ApiConfig.registerEndpoint, data: {'name': name, 'email': email, 'password': password});
      if (response.statusCode == 200) {
        return AuthUserModel.fromJson(response.data);
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