import 'package:cleancode_app/core/config/api_config.dart';
import 'package:cleancode_app/core/constants/app_constants.dart';
import 'package:cleancode_app/core/network/dio_client_sl.dart';
import 'package:cleancode_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

abstract class ModulesRemoteDataSource {
  Future<Either> getModules();
}

class ModulesRemoteDataSourceImpl extends ModulesRemoteDataSource{
  @override
  Future<Either> getModules() async {
    try {
      final authRepository = GetIt.I<AuthRepository>();
      final user = await authRepository.getLoggedInUser();
      var response = await sl<DioClient>().get(ApiConfig.modulesEndpoint(user?.role?.id ?? AppConstants.userRoleId));
      return Right(response.data);
    } on DioException catch (e) {
      String message = e.response?.data['msg'] ?? e.response?.data['message'] ?? e.message ?? e.response?.statusMessage ?? 'Error Desconocido';
      if(e.response?.statusCode == 403){
        message = '$message (${e.response?.statusCode})';
      }
      return Left(message);
    }
  }
}