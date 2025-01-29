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
  Future<Either<Failure, List<RoleModel>>> getRoles() async {
    try {
      final result = await remoteDataSource.getRoles();
      return Right(result);
    } on Exception catch (e) {
      debugPrint("RoleRepositoryImpl ${e}");
      // if(e.contains('403')){
      //   return Left(ForbiddenFailure(e.message));
      // }
      return Left(ServerFailure(e.toString()));
    }
  }
}