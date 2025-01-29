import 'package:cleancode_app/features/roles/data/models/role_model.dart';

abstract class RoleState {}

class RoleInitialState extends RoleState {}

class RoleLoadingState extends RoleState {}

class RoleSuccessState extends RoleState {
  final List<RoleModel> roles;

  RoleSuccessState(this.roles);
}

class RoleFailureState extends RoleState {
  final String message;

  RoleFailureState(this.message);
}

class ForbiddenActionState extends RoleState {
  final String message;

  ForbiddenActionState(this.message);
}