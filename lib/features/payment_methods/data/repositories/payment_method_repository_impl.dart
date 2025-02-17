import 'package:cleancode_app/features/payment_methods/data/datasources/payment_methods_api_service.dart';
import 'package:cleancode_app/features/payment_methods/data/models/item_req_params.dart';
import 'package:cleancode_app/features/payment_methods/domain/repositories/payment_method_repository.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class PaymentMethodRepositoryImpl implements PaymentMethodRepository {

  @override
  Future<Either> getAllItems() {
    return sl<PaymentMethodApiService>().getAllItems();
  }

  @override
  Future<Either> getItem(PaymentMethodReqParams params) {
    return sl<PaymentMethodApiService>().getItem(params);
  }

    @override
  Future<Either> postItem(PaymentMethodReqParams params) {
    return sl<PaymentMethodApiService>().postItem(params);
  }

  @override
  Future<Either> updateItem(PaymentMethodReqParams params) {
    return sl<PaymentMethodApiService>().updateItem(params);
  }

    @override
  Future<Either> deleteItem(PaymentMethodReqParams params) {
    return sl<PaymentMethodApiService>().deleteItem(params);
  }

}