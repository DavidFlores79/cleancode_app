import 'package:cleancode_app/features/users/domain/entities/user.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final List<User> users;

  UserSuccess(this.users);
}

class UserFailure extends UserState {
  final String message;

  UserFailure(this.message);
}