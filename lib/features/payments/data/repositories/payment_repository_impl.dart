import 'package:cleancode_app/features/payments/data/datasources/payments_api_service.dart';
import 'package:cleancode_app/features/payments/data/models/item_req_params.dart';
import 'package:cleancode_app/features/payments/domain/repositories/payment_repository.dart';
import 'package:cleancode_app/features/users/data/datasources/user_api_service.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class PaymentRepositoryImpl implements PaymentRepository {

  @override
  Future<Either> getAllItems() {
    return sl<PaymentApiService>().getAllItems();
  }

  @override
  Future<Either> getItem(PaymentReqParams params) {
    return sl<PaymentApiService>().getItem(params);
  }

    @override
  Future<Either> postItem(PaymentReqParams params) {
    return sl<PaymentApiService>().postItem(params);
  }

  @override
  Future<Either> updateItem(PaymentReqParams params) {
    return sl<PaymentApiService>().updateItem(params);
  }

    @override
  Future<Either> deleteItem(PaymentReqParams params) {
    return sl<PaymentApiService>().deleteItem(params);
  }
  
  @override
  Future<Either> searchItems(String query) {
    return sl<UserApiService>().searchItems(query);
  }

}