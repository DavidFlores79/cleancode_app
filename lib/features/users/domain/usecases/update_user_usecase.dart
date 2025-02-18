import 'package:cleancode_app/core/usecase/usecase.dart';
import 'package:cleancode_app/features/users/data/models/item_req_params.dart';
import 'package:cleancode_app/features/users/domain/repositories/user_repository.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class UpdateUserUsecase implements Usecase<Either, UserReqParams>{
  @override
  Future<Either> call({UserReqParams? query}) async {
    return sl<UserRepository>().updateItem(query!);
  }
}