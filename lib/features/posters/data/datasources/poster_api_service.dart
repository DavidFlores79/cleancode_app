import 'package:cleancode_app/core/config/api_config.dart';
import 'package:cleancode_app/core/network/dio_client_sl.dart';
import 'package:cleancode_app/features/posters/data/models/item_req_params.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class PosterApiService {
    Future<Either> getAllItems();
    Future<Either> getItem(PosterReqParams params);
    Future<Either> postItem(PosterReqParams params);
    Future<Either> updateItem(PosterReqParams params);
    Future<Either> deleteItem(PosterReqParams params);
}

class PosterApiServiceImpl implements PosterApiService {

  @override
  Future<Either> getAllItems() async {
    try {
      final response = await sl<DioClient>().get(ApiConfig.postersEndpoint);
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message;
      return Left(message);
    }
  }

  @override
  Future<Either> getItem(PosterReqParams params) async {
    try {
      final response = await sl<DioClient>().get('${ApiConfig.postersEndpoint}/${params.id}');
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message; //nodejs & standar API
      return Left(message);
    }
  }

    @override
  Future<Either> postItem(PosterReqParams params) async {
    try {
      final response = await sl<DioClient>().post(ApiConfig.postersEndpoint, data: params.toMap());
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message; //nodejs & standar API
      return Left(message);
    }
  }

  @override
  Future<Either> updateItem(PosterReqParams params) async {
    try {
      final response = await sl<DioClient>().put('${ApiConfig.postersEndpoint}/${params.id}', data: params.toMap());
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message; //nodejs & standar API
      return Left(message);
    }
  }

  @override
  Future<Either> deleteItem(PosterReqParams params) async {
    try {
      final response = await sl<DioClient>().delete('${ApiConfig.postersEndpoint}/${params.id}');
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message; //nodejs & standar API
      return Left(message);
    }
  }

}