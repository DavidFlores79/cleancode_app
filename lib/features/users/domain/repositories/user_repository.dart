import 'package:cleancode_app/features/users/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:cleancode_app/core/errors/failures.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserModel>>> getUsers();
}