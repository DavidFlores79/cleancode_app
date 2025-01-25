import 'package:dartz/dartz.dart';
import 'package:cleancode_app/core/errors/failures.dart';
import 'package:cleancode_app/features/users/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUsers();
}