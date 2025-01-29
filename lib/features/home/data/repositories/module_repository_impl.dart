import 'package:cleancode_app/features/home/data/datasources/modules_remote_datasource.dart';
import 'package:cleancode_app/features/home/domain/repositories/module_repository.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class ModuleRepositoryImpl implements ModuleRepository{


  @override
  Future<Either> getModules() {
    return sl<ModulesRemoteDataSource>().getModules();
  }

}