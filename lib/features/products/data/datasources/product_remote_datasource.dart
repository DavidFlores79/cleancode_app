import 'package:dio/dio.dart';
import 'package:cleancode_app/core/config/api_config.dart';
import 'package:cleancode_app/core/network/dio_client.dart';
import 'package:cleancode_app/features/products/data/models/product_model.dart';
abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
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
    } on DioException catch(e) {
      throw Exception(e.message);
    }
     catch(e) {
         throw Exception(e.toString());
     }
  }
}