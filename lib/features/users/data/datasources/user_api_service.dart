import 'package:cleancode_app/core/config/api_config.dart';
import 'package:cleancode_app/core/network/dio_client_sl.dart';
import 'package:cleancode_app/features/users/data/models/item_req_params.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class UserApiService {
    Future<Either> getAllItems();
    Future<Either> getItem(UserReqParams params);
    Future<Either> postItem(UserReqParams params);
    Future<Either> updateItem(UserReqParams params);
    Future<Either> deleteItem(UserReqParams params);
}

class UserApiServiceImpl implements UserApiService {

  @override
  Future<Either> getAllItems() async {
    try {
      final response = await sl<DioClient>().get(ApiConfig.usersEndpoint);
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message;
      return Left(message);
    }
  }

  @override
  Future<Either> getItem(UserReqParams params) async {
    try {
      final response = await sl<DioClient>().get('${ApiConfig.usersEndpoint}/${params.id}');
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data?['msg'] ?? e.message; //nodejs & standar API
      return Left(message);
    }
  }

    @override
  Future<Either> postItem(UserReqParams params) async {
    try {
      final response = await sl<DioClient>().post(ApiConfig.usersEndpoint, data: params.toMap());
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message; //nodejs & standar API
      return Left(message);
    }
  }

  @override
  Future<Either> updateItem(UserReqParams params) async {
    try {
      final response = await sl<DioClient>().put('${ApiConfig.usersEndpoint}/${params.id}', data: params.toMap());
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message; //nodejs & standar API
      return Left(message);
    }
  }

  @override
  Future<Either> deleteItem(UserReqParams params) async {
    try {
      final response = await sl<DioClient>().delete('${ApiConfig.usersEndpoint}/${params.id}');
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message; //nodejs & standar API
      return Left(message);
    }
  }

}