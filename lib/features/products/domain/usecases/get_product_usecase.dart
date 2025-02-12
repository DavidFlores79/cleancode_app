import 'package:cleancode_app/core/usecase/usecase.dart';
import 'package:cleancode_app/features/products/data/models/product_req_params.dart';
import 'package:cleancode_app/features/products/domain/repositories/product_repository.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetProductUsecase implements Usecase<Either, ProductReqParams> {

  @override
  Future<Either> call({ProductReqParams? param}) async {
    return sl<ProductRepository>().getProduct(param!);
  }
}