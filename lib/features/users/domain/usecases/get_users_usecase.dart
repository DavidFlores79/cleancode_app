import 'package:dartz/dartz.dart';
import 'package:cleancode_app/core/errors/failures.dart';
import 'package:cleancode_app/features/users/domain/entities/user.dart';
import 'package:cleancode_app/features/users/domain/repositories/user_repository.dart';

class GetUsersUseCase {
  final UserRepository repository;

  GetUsersUseCase({required this.repository});

  Future<Either<Failure, List<User>>> call() async {
    return await repository.getUsers();
  }
}