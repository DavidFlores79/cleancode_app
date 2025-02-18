import 'package:cleancode_app/features/users/data/models/user_model.dart';

abstract class UserState {}

class UserInitialState implements UserState {}
class UserLoadingState implements UserState {}
class GetAllUsersSuccessState implements UserState {
  final List<UserModel> items;
  GetAllUsersSuccessState(this.items);
}
class GetOneUserSuccessState implements UserState {
  final UserModel item;
  GetOneUserSuccessState(this.item);
}
class UpdateUserSuccessState implements UserState {
  final UserModel item;
  UpdateUserSuccessState(this.item);
}
class CreateUserSuccessState implements UserState {
  final UserModel item;
  CreateUserSuccessState(this.item);
}
class DeleteUserSuccessState implements UserState {}
class UserFailureState implements UserState {
  final String message;
  UserFailureState(this.message);
}

class ForbiddenActionState extends UserState {
  final String message;

  ForbiddenActionState(this.message);
}