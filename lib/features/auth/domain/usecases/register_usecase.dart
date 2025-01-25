import 'package:dartz/dartz.dart';
import 'package:cleancode_app/core/errors/failures.dart';
import 'package:cleancode_app/features/auth/domain/entities/user.dart';
import 'package:cleancode_app/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<Either<Failure, User>> call(String name, String email, String password) async {
    return await repository.register(name, email, password);
  }
}