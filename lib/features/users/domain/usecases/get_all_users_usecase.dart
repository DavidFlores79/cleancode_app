import 'package:cleancode_app/core/usecase/usecase.dart';
import 'package:cleancode_app/features/users/data/models/item_req_params.dart';
import 'package:cleancode_app/features/users/domain/repositories/user_repository.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetAllUsersUsecase implements Usecase<Either, UserReqParams>{
  @override
  Future<Either> call({UserReqParams? params}) async {
    return sl<UserRepository>().getAllItems();
  }
}