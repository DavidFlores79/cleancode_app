import 'package:cleancode_app/features/products/data/models/product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final List<ProductModel> products;

  ProductSuccess(this.products);
}

class ProductFailure extends ProductState {
  final String message;

  ProductFailure(this.message);
}