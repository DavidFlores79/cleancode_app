import 'package:cleancode_app/core/domain/entities/api_response.dart';
import 'package:cleancode_app/features/home/domain/entities/module.dart';

abstract class ModuleState {}

class ModuleInitialState extends ModuleState {}
class ModuleLoadingState extends ModuleState {}
class ModuleSuccessState extends ModuleState {
  final List<Module> modules;
  ModuleSuccessState(this.modules);
}
class ModuleFailureState extends ModuleState {
  final String errorMessage;

  ModuleFailureState({required this.errorMessage});
}
