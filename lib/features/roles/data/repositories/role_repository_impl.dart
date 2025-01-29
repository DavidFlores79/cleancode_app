import 'package:cleancode_app/core/errors/failures.dart';
import 'package:cleancode_app/features/roles/data/datasources/roles_remote_datasource.dart';
import 'package:cleancode_app/features/roles/data/models/role_model.dart';
import 'package:cleancode_app/features/roles/domain/repositories/role_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
class RoleRepositoryImpl implements RoleRepository {
  final RoleRemoteDataSource remoteDataSource;

  RoleRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ServerFailure, List<RoleModel>>> getRoles() async {
    try {
      final result = await remoteDataSource.getRoles();
      return Right(result);
    } on Exception catch (e) {
      debugPrint("paso 3 ${e.toString()}");
      return Left(ServerFailure("$e"));
    }
  }
}