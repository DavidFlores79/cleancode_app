import 'package:cleancode_app/core/errors/failures.dart';
import 'package:cleancode_app/features/roles/data/models/role_model.dart';
import 'package:dartz/dartz.dart';

abstract class RoleRepository {
  Future<Either<Failure, List<RoleModel>>> getRoles();
}