import 'package:cleancode_app/features/products/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({required super.id, required super.name, required super.price});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'], name: json['name'], price: json['price']);
  }
}