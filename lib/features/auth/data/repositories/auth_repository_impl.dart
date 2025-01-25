import 'package:dartz/dartz.dart';
import 'package:cleancode_app/core/errors/failures.dart';
import 'package:cleancode_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:cleancode_app/features/auth/domain/entities/user.dart';
import 'package:cleancode_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
      try {
      final result = await remoteDataSource.login(email, password);
      return Right(result);
    } on Exception catch (e) {
        return Left(AuthFailure(e.toString()));
    }
  }
    @override
  Future<Either<Failure, User>> register(String name, String email, String password) async {
     try {
      final result = await remoteDataSource.register(name, email, password);
      return Right(result);
    } on Exception catch (e) {
        return Left(AuthFailure(e.toString()));
    }
  }
}