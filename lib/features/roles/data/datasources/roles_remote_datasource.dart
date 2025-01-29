import 'package:cleancode_app/core/config/api_config.dart';
import 'package:cleancode_app/core/network/dio_client.dart';
import 'package:cleancode_app/features/roles/data/models/role_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class RoleRemoteDataSource {
  Future<List<RoleModel>> getRoles();
}

class RoleRemoteDataSourceImpl extends RoleRemoteDataSource {
  final DioClient dioClient;

  RoleRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<RoleModel>> getRoles() async {
    try {
      final response = await dioClient.dio.get(ApiConfig.rolesEndpoint);
      if (response.statusCode == 200) {
        return (response.data['data'] as List<dynamic>)
            .map((json) => RoleModel.fromMap(json))
            .toList();
      } else {
        throw Exception('Failed to get Roles');
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? e.message ?? e.response?.statusMessage ?? 'Error Desconocido';
      if(e.response?.statusCode == 403){
        message = '$message (${e.response?.statusCode})';
      }
      throw Exception(message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
