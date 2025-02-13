import 'dart:async';
import 'package:cleancode_app/core/domain/entities/auth_response.dart';
import 'package:dio/dio.dart';
import 'package:cleancode_app/core/config/api_config.dart';
import 'package:cleancode_app/core/network/dio_client.dart';
import 'package:cleancode_app/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';
abstract class AuthRemoteDataSource {
  Future<AuthResponse> login(String email, String password);
  Future<AuthResponse> register(String name, String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<AuthResponse> login(String email, String password) async {
    try {
      debugPrint(ApiConfig.loginEndpoint);
      debugPrint('email: $email password: $password');
      final response = await dioClient.dio.post(ApiConfig.loginEndpoint, data: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        final data = response.data;
        return AuthResponse.fromMap(data);
      } else {
        throw Exception('Failed to login');
      }
    } on DioException catch (e) {
      String message = '${e.message ?? 'Error Desconocido'} ${(e.response?.statusCode == 403) ? e.response?.statusCode: ''}';
      throw Exception(message);
    }
  }

    @override
  Future<AuthResponse> register(String name, String email, String password) async {
    try {
      final response = await dioClient.dio.post(ApiConfig.registerEndpoint, data: {'name': name, 'email': email, 'password': password});
      if (response.statusCode == 201) {
        return AuthResponse.fromMap(response.data);
      } else {
        throw Exception('Failed to register');
      }
    } on DioException catch (e) {
      String message = '${e.message ?? 'Error Desconocido'} ${(e.response?.statusCode == 403) ? e.response?.statusCode: ''}';
      throw Exception(message);
    }
  }
}