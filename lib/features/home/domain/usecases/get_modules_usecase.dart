import 'package:cleancode_app/core/usecase/usecase.dart';
import 'package:cleancode_app/features/home/domain/repositories/module_repository.dart';
import 'package:cleancode_app/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetModulesUsecase implements Usecase<Either, String>{
  
  @override
  Future<Either> call({String? query}) {
    return sl<ModuleRepository>().getModules();
  }

}