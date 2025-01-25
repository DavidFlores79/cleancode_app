import 'package:dartz/dartz.dart';
import 'package:cleancode_app/core/errors/failures.dart';
import 'package:cleancode_app/features/products/data/datasources/product_remote_datasource.dart';
import 'package:cleancode_app/features/products/domain/entities/product.dart';
import 'package:cleancode_app/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final result = await remoteDataSource.getProducts();
      return Right(result);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}