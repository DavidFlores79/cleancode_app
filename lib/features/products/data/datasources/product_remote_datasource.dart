import 'package:cleancode_app/features/products/data/models/product_req_params.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:cleancode_app/core/config/api_config.dart';
import 'package:cleancode_app/core/network/dio_client.dart';
import 'package:cleancode_app/core/network/dio_client_sl.dart' as dioSL;
import 'package:cleancode_app/features/products/data/models/product_model.dart';
import 'package:flutter/material.dart';
abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<Either> getProduct(ProductReqParams id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final DioClient dioClient;

  ProductRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dioClient.dio.get(ApiConfig.productsEndpoint);

      if (response.statusCode == 200) {
        return (response.data['data'] as List<dynamic>)
            .map((json) => ProductModel.fromMap(json))
            .toList();
      } else {
        throw Exception('Failed to get products');
      }
    } on DioException catch (e) {
      String message = '${e.message ?? 'Error Desconocido'} ${(e.response?.statusCode == 403) ? e.response?.statusCode: ''}';
      throw Exception(message);
    }
  }
  
  @override
  Future<Either> getProduct(ProductReqParams params) async {
    debugPrint("====> ID: $id");
    try {

      final response = await sl<dioSL.DioClient>().get('${ApiConfig.productsEndpoint}/${params.id}');
      return Right(response);
      
    } on DioException catch (e) {
      String message = '${e.message ?? 'Error Desconocido'} ${(e.response?.statusCode == 403) ? e.response?.statusCode: ''}';
      return Left(message);
    }
  }
}
