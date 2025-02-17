import 'package:cleancode_app/features/payment_methods/data/models/item_req_params.dart';
import 'package:dartz/dartz.dart';

abstract class PaymentMethodRepository {
  Future<Either> getAllItems();
  Future<Either> getItem(PaymentMethodReqParams params);
  Future<Either> postItem(PaymentMethodReqParams params);
  Future<Either> updateItem(PaymentMethodReqParams params);
  Future<Either> deleteItem(PaymentMethodReqParams params);
}