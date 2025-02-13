import 'package:cleancode_app/features/categories/data/models/item_req_params.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepository {
  Future<Either> getAllItems();
  Future<Either> getItem(CategoryReqParams params);
  Future<Either> postItem(CategoryReqParams params);
  Future<Either> updateItem(CategoryReqParams params);
  Future<Either> deleteItem(CategoryReqParams params);
}