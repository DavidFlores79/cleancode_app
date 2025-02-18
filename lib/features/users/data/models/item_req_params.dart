import 'package:cleancode_app/core/domain/entities/user.dart';

class UserReqParams {
  final String id;
  final String? name;
  final String? email;
  final String? image;
  final Role? role;
  final bool? status;

  UserReqParams({required this.id, this.name, this.status, this.email, this.image, this.role});

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      '_id': id,
      'name': name,
      'email': email,
      'image': image,
      'role': role,
      'status': status,
    };
  }
}