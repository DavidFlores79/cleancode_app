import 'package:cleancode_app/features/users/data/models/item_req_params.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either> getAllItems();
  Future<Either> getItem(UserReqParams params);
  Future<Either> postItem(UserReqParams params);
  Future<Either> updateItem(UserReqParams params);
  Future<Either> deleteItem(UserReqParams params);
}