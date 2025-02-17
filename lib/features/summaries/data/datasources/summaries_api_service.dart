import 'package:cleancode_app/core/config/api_config.dart';
import 'package:cleancode_app/core/network/dio_client_sl.dart';
import 'package:cleancode_app/features/summaries/data/models/item_req_params.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class SummaryApiService {
    Future<Either> getAllItems();
    Future<Either> getItem(SummaryReqParams params);
    Future<Either> postItem(SummaryReqParams params);
    Future<Either> updateItem(SummaryReqParams params);
    Future<Either> deleteItem(SummaryReqParams params);
}

class SummaryApiServiceImpl implements SummaryApiService {

  @override
  Future<Either> getAllItems() async {
    try {
      final response = await sl<DioClient>().get(ApiConfig.summariesEndpoint);
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message;
      return Left(message);
    }
  }

  @override
  Future<Either> getItem(SummaryReqParams params) async {
    try {
      final response = await sl<DioClient>().get('${ApiConfig.summariesEndpoint}/${params.id}');
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data?['msg'] ?? e.message; //nodejs & standar API
      return Left(message);
    }
  }

    @override
  Future<Either> postItem(SummaryReqParams params) async {
    try {
      final response = await sl<DioClient>().post(ApiConfig.summariesEndpoint, data: params.toMap());
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message; //nodejs & standar API
      return Left(message);
    }
  }

  @override
  Future<Either> updateItem(SummaryReqParams params) async {
    try {
      final response = await sl<DioClient>().put('${ApiConfig.summariesEndpoint}/${params.id}', data: params.toMap());
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message; //nodejs & standar API
      return Left(message);
    }
  }

  @override
  Future<Either> deleteItem(SummaryReqParams params) async {
    try {
      final response = await sl<DioClient>().delete('${ApiConfig.summariesEndpoint}/${params.id}');
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message; //nodejs & standar API
      return Left(message);
    }
  }

}