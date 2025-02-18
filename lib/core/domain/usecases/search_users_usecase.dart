import 'package:cleancode_app/core/usecase/usecase.dart';
import 'package:cleancode_app/features/users/domain/repositories/user_repository.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class SearchUsersUsecase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({query}) {
    return sl<UserRepository>().searchItems(query);
  }
}
