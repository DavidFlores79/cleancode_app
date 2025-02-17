import 'package:cleancode_app/core/config/api_config.dart';
import 'package:cleancode_app/core/network/dio_client_sl.dart';
import 'package:cleancode_app/features/payments/data/models/item_req_params.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class PaymentApiService {
    Future<Either> getAllItems();
    Future<Either> getItem(PaymentReqParams params);
    Future<Either> postItem(PaymentReqParams params);
    Future<Either> updateItem(PaymentReqParams params);
    Future<Either> deleteItem(PaymentReqParams params);
}

class PaymentApiServiceImpl implements PaymentApiService {

  @override
  Future<Either> getAllItems() async {
    try {
      final response = await sl<DioClient>().get(ApiConfig.paymentsEndpoint);
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message;
      return Left(message);
    }
  }

  @override
  Future<Either> getItem(PaymentReqParams params) async {
    try {
      final response = await sl<DioClient>().get('${ApiConfig.paymentsEndpoint}/${params.id}');
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data?['msg'] ?? e.message; //nodejs & standar API
      return Left(message);
    }
  }

    @override
  Future<Either> postItem(PaymentReqParams params) async {
    try {
      final response = await sl<DioClient>().post(ApiConfig.paymentsEndpoint, data: params.toMap());
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message; //nodejs & standar API
      return Left(message);
    }
  }

  @override
  Future<Either> updateItem(PaymentReqParams params) async {
    try {
      final response = await sl<DioClient>().put('${ApiConfig.paymentsEndpoint}/${params.id}', data: params.toMap());
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message; //nodejs & standar API
      return Left(message);
    }
  }

  @override
  Future<Either> deleteItem(PaymentReqParams params) async {
    try {
      final response = await sl<DioClient>().delete('${ApiConfig.paymentsEndpoint}/${params.id}');
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message; //nodejs & standar API
      return Left(message);
    }
  }

}