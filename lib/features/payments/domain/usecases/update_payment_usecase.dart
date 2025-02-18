import 'package:cleancode_app/core/usecase/usecase.dart';
import 'package:cleancode_app/features/payments/data/models/item_req_params.dart';
import 'package:cleancode_app/features/payments/domain/repositories/payment_repository.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class UpdatePaymentUsecase implements Usecase<Either, PaymentReqParams>{
  @override
  Future<Either> call({PaymentReqParams? query}) async {
    return sl<PaymentRepository>().updateItem(query!);
  }
}