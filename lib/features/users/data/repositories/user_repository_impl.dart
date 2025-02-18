import 'package:cleancode_app/features/users/data/datasources/user_api_service.dart';
import 'package:cleancode_app/features/users/data/models/item_req_params.dart';
import 'package:cleancode_app/features/users/domain/repositories/user_repository.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {

  @override
  Future<Either> getAllItems() {
    return sl<UserApiService>().getAllItems();
  }

  @override
  Future<Either> getItem(UserReqParams params) {
    return sl<UserApiService>().getItem(params);
  }

    @override
  Future<Either> postItem(UserReqParams params) {
    return sl<UserApiService>().postItem(params);
  }

  @override
  Future<Either> updateItem(UserReqParams params) {
    return sl<UserApiService>().updateItem(params);
  }

    @override
  Future<Either> deleteItem(UserReqParams params) {
    return sl<UserApiService>().deleteItem(params);
  }
  
  @override
  Future<Either> searchItems(String query) {
    return sl<UserApiService>().searchItems(query);
  }

}