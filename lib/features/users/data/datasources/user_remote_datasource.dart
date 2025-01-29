import 'package:dio/dio.dart';
import 'package:cleancode_app/core/config/api_config.dart';
import 'package:cleancode_app/core/network/dio_client.dart';
import 'package:cleancode_app/features/users/data/models/user_model.dart';
import 'package:flutter/material.dart';

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
    } on DioException catch(e) {
      debugPrint("DioEx====== ${e.type}");
      String message = e.response?.data['message'] ?? e.message ?? e.response?.statusMessage ?? 'Error Desconocido';
      if(e.response?.statusCode == 403){
        message = '$message (${e.response?.statusCode})';
      }
      throw Exception(message);
    }
    catch (e) {
        debugPrint("Ex====== ${e}");
        throw Exception(e.toString());
    }
  }
}