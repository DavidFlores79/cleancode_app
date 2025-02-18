import 'package:cleancode_app/features/payments/data/models/item_req_params.dart';
import 'package:dartz/dartz.dart';

abstract class PaymentRepository {
  Future<Either> getAllItems();
  Future<Either> searchItems(String query);
  Future<Either> getItem(PaymentReqParams params);
  Future<Either> postItem(PaymentReqParams params);
  Future<Either> updateItem(PaymentReqParams params);
  Future<Either> deleteItem(PaymentReqParams params);
}