import 'package:dartz/dartz.dart';
import 'package:cleancode_app/core/errors/failures.dart';
import 'package:cleancode_app/features/products/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
}