import 'dart:convert';
import 'package:cleancode_app/core/domain/entities/user.dart';

class AuthUserModel extends User {
  AuthUserModel({
    super.id, 
    super.name, 
    super.email,
    super.image,
    super.role,
    super.status,
    super.google,
    super.createdAt,
    super.updatedAt,
  });

  factory AuthUserModel.fromJson(String str) => AuthUserModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AuthUserModel.fromMap(Map<String, dynamic> json) => AuthUserModel(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        image: json["image"],
        role: json["role"] == null ? null : Role.fromMap(json["role"]),
        status: json["status"],
        google: json["google"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "email": email,
        "image": image,
        "role": role?.toMap(),
        "status": status,
        "google": google,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };
}