import 'package:cleancode_app/features/products/data/models/product_model.dart';
import 'package:dartz/dartz.dart';
import 'package:cleancode_app/core/errors/failures.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductModel>>> getProducts();
}