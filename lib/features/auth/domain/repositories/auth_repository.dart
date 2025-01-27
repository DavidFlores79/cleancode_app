import 'package:cleancode_app/core/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:cleancode_app/core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register(
    String name,
    String email,
    String password,
  );
  Future<User?> getLoggedInUser();
  Future<String?> getToken();
  Future<bool> isLoggedIn();
  Future<void> logout();
}
