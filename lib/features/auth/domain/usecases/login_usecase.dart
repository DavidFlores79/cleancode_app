import 'package:dartz/dartz.dart';
import 'package:cleancode_app/core/errors/failures.dart';
import 'package:cleancode_app/features/auth/domain/entities/user.dart';
import 'package:cleancode_app/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<Failure, User>> call(String email, String password) async {
    return await repository.login(email, password);
  }
}