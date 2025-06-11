import 'package:cleancode_app/features/users/data/models/user_model.dart';

abstract class UserEvent {}

class GetAllUsers implements UserEvent {
  final int? page;
  final int? pageSize;

  GetAllUsers({this.page, this.pageSize});
}
class SearchUsers implements UserEvent {
  final String query;
  SearchUsers(this.query);
}
class GetOneUser implements UserEvent {
  final String itemId;
  GetOneUser(this.itemId);
}
class CreateUser extends UserEvent {
  final UserModel item;
  CreateUser(this.item);
}
class UpdateUser extends UserEvent {
  final UserModel item;
  UpdateUser(this.item);
}
class DeleteUser extends UserEvent {
  final String itemId;
  DeleteUser(this.itemId);
}