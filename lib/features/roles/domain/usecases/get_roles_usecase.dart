import 'package:cleancode_app/core/errors/failures.dart';
import 'package:cleancode_app/features/roles/data/models/role_model.dart';
import 'package:cleancode_app/features/roles/domain/repositories/role_repository.dart';
import 'package:dartz/dartz.dart';

class GetRolesUsecase {
  final RoleRepository repository;

  GetRolesUsecase({required this.repository});

  Future<Either<Failure, List<RoleModel>>> call() async {
    return await repository.getRoles();
  }
}