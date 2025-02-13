import 'package:cleancode_app/core/config/api_config.dart';
import 'package:cleancode_app/core/network/dio_client_sl.dart';
import 'package:cleancode_app/features/categories/data/models/item_req_params.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class CategoryApiService {
    Future<Either> getAllItems();
    Future<Either> getItem(CategoryReqParams params);
    Future<Either> postItem(CategoryReqParams params);
    Future<Either> updateItem(CategoryReqParams params);
    Future<Either> deleteItem(CategoryReqParams params);
}

class CategoryApiServiceImpl implements CategoryApiService {

  @override
  Future<Either> getAllItems() async {
    try {
      final response = await sl<DioClient>().get(ApiConfig.categoriesEndpoint);
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message;
      return Left(message);
    }
  }

  @override
  Future<Either> getItem(CategoryReqParams params) async {
    try {
      final response = await sl<DioClient>().get('${ApiConfig.categoriesEndpoint}/${params.id}');
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message; //nodejs & standar API
      return Left(message);
    }
  }

    @override
  Future<Either> postItem(CategoryReqParams params) async {
    try {
      final response = await sl<DioClient>().post(ApiConfig.categoriesEndpoint, data: params.toMap());
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message; //nodejs & standar API
      return Left(message);
    }
  }

  @override
  Future<Either> updateItem(CategoryReqParams params) async {
    try {
      final response = await sl<DioClient>().put('${ApiConfig.categoriesEndpoint}/${params.id}', data: params.toMap());
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message; //nodejs & standar API
      return Left(message);
    }
  }

  @override
  Future<Either> deleteItem(CategoryReqParams params) async {
    try {
      final response = await sl<DioClient>().delete('${ApiConfig.categoriesEndpoint}/${params.id}');
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message; //nodejs & standar API
      return Left(message);
    }
  }

}