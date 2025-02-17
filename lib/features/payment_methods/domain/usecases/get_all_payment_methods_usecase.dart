import 'package:cleancode_app/core/usecase/usecase.dart';
import 'package:cleancode_app/features/payment_methods/data/models/item_req_params.dart';
import 'package:cleancode_app/features/payment_methods/domain/repositories/payment_method_repository.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetAllPaymentMethodsUsecase implements Usecase<Either, PaymentMethodReqParams>{
  @override
  Future<Either> call({PaymentMethodReqParams? params}) async {
    return sl<PaymentMethodRepository>().getAllItems();
  }
}