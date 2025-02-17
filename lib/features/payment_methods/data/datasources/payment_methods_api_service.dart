import 'package:cleancode_app/core/config/api_config.dart';
import 'package:cleancode_app/core/network/dio_client_sl.dart';
import 'package:cleancode_app/features/payment_methods/data/models/item_req_params.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class PaymentMethodApiService {
    Future<Either> getAllItems();
    Future<Either> getItem(PaymentMethodReqParams params);
    Future<Either> postItem(PaymentMethodReqParams params);
    Future<Either> updateItem(PaymentMethodReqParams params);
    Future<Either> deleteItem(PaymentMethodReqParams params);
}

class PaymentMethodApiServiceImpl implements PaymentMethodApiService {

  @override
  Future<Either> getAllItems() async {
    try {
      final response = await sl<DioClient>().get(ApiConfig.paymentMethodsEndpoint);
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message;
      return Left(message);
    }
  }

  @override
  Future<Either> getItem(PaymentMethodReqParams params) async {
    try {
      final response = await sl<DioClient>().get('${ApiConfig.paymentMethodsEndpoint}/${params.id}');
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data?['msg'] ?? e.message; //nodejs & standar API
      return Left(message);
    }
  }

    @override
  Future<Either> postItem(PaymentMethodReqParams params) async {
    try {
      final response = await sl<DioClient>().post(ApiConfig.paymentMethodsEndpoint, data: params.toMap());
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message; //nodejs & standar API
      return Left(message);
    }
  }

  @override
  Future<Either> updateItem(PaymentMethodReqParams params) async {
    try {
      final response = await sl<DioClient>().put('${ApiConfig.paymentMethodsEndpoint}/${params.id}', data: params.toMap());
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message; //nodejs & standar API
      return Left(message);
    }
  }

  @override
  Future<Either> deleteItem(PaymentMethodReqParams params) async {
    try {
      final response = await sl<DioClient>().delete('${ApiConfig.paymentMethodsEndpoint}/${params.id}');
      return Right(response);
    } on DioException catch (e) {
      final message = e.response?.data['msg'] ?? e.message; //nodejs & standar API
      return Left(message);
    }
  }

}