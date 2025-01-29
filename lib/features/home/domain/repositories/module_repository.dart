import 'package:dartz/dartz.dart';

abstract class ModuleRepository {
  Future<Either> getModules();
}