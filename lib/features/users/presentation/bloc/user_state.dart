import 'package:cleancode_app/features/users/data/models/user_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final List<UserModel> users;

  UserSuccess(this.users);
}

class UserFailure extends UserState {
  final String message;

  UserFailure(this.message);
}