import 'package:cleancode_app/features/categories/data/datasources/category_api_service.dart';
import 'package:cleancode_app/features/categories/data/models/item_req_params.dart';
import 'package:cleancode_app/features/categories/domain/repositories/category_repository.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class CategoryRepositoryImpl implements CategoryRepository {

  @override
  Future<Either> getAllItems() {
    return sl<CategoryApiService>().getAllItems();
  }

  @override
  Future<Either> getItem(CategoryReqParams params) {
    return sl<CategoryApiService>().getItem(params);
  }

    @override
  Future<Either> postItem(CategoryReqParams params) {
    return sl<CategoryApiService>().postItem(params);
  }

  @override
  Future<Either> updateItem(CategoryReqParams params) {
    return sl<CategoryApiService>().updateItem(params);
  }

    @override
  Future<Either> deleteItem(CategoryReqParams params) {
    return sl<CategoryApiService>().deleteItem(params);
  }

}