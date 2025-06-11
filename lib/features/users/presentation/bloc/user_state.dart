import 'package:cleancode_app/features/users/data/models/user_model.dart';
import 'package:cleancode_app/features/users/domain/entities/pageable_users.dart';

abstract class UserState {}

class UserInitialState implements UserState {}
class UserLoadingState implements UserState {}
class UserLoadingMoreState extends UserState {} // New state for loading more users

class GetAllUsersSuccessState implements UserState {
  final PageableUsers pageableUsers; // Changed from List<UserModel> to PageableUsers
  GetAllUsersSuccessState(this.pageableUsers);
}

class UserMaxReachedState extends UserState { // New state for max users reached
  final PageableUsers pageableUsers;
  UserMaxReachedState(this.pageableUsers);
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

class SearchUsersSuccessState implements UserState {
  final List<UserModel> items;
  SearchUsersSuccessState(this.items);
}

class ForbiddenActionState extends UserState {
  final String message;

  ForbiddenActionState(this.message);
}