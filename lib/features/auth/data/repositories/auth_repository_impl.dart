import 'dart:convert';

import 'package:cleancode_app/core/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:cleancode_app/core/errors/failures.dart';
import 'package:cleancode_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:cleancode_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
      try {
      final result = await remoteDataSource.login(email, password);
      _setLoggedInUser(result.user ?? User(), result.jwt ?? '');
      return Right(result.user!);
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

  Future<void> _setLoggedInUser(User user, String token) async {
    final FlutterSecureStorage storage = GetIt.I<FlutterSecureStorage>();
    final userJson = json.encode(user.toJson());
    await storage.write(key: 'user', value: userJson);
    if(token.isNotEmpty) {
         await storage.write(key: 'token', value: token);
     }
  }
  
  @override
  Future<User?> getLoggedInUser() async {
    final FlutterSecureStorage storage = GetIt.I<FlutterSecureStorage>();
    final userJson = await storage.read(key: 'user');
    if (userJson == null) {
        return null;
    }
    final userMap = json.decode(userJson);
    return User.fromJson(userMap);
  }
  
  @override
  Future<bool> isLoggedIn() async {
    final user = await getLoggedInUser();
    return user != null;
  }
  
  @override
  Future<void> logout() async {
    final FlutterSecureStorage storage = GetIt.I<FlutterSecureStorage>();
     await storage.delete(key: 'token');
     await storage.delete(key: 'user');
  }
  
  @override
  Future<String?> getToken() async {
    final FlutterSecureStorage storage = GetIt.I<FlutterSecureStorage>();
    final token = await storage.read(key: 'token');
    if (token == null) {
        return null;
    }
    return token;
  }
}