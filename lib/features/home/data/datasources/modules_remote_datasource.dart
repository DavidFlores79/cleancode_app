import 'package:cleancode_app/core/config/api_config.dart';
import 'package:cleancode_app/core/network/dio_client_sl.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class ModulesRemoteDataSource {
  Future<Either> getModules();
}

class ModulesRemoteDataSourceImpl extends ModulesRemoteDataSource{
  @override
  Future<Either> getModules() async {
    try {
      var response = await sl<DioClient>().get(ApiConfig.modulesEndpoint('644dc7bc999ad1fe7e0471a9'));
      return Right(response);
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? e.message ?? e.response?.statusMessage ?? 'Error Desconocido';
      if(e.response?.statusCode == 403){
        message = '$message (${e.response?.statusCode})';
      }
      return Left(message);
    }
  }
}