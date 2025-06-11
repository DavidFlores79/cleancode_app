import 'dart:convert';
import 'package:cleancode_app/features/users/domain/entities/user.dart' as UserEntity;

class UserModel {
    String? id;
    String? name;
    String? email;
    String? password;
    String? image;
    dynamic role;
    bool? status;
    bool? google;
    String? createdAt;
    String? updatedAt;

    UserModel({
        this.id,
        this.name,
        this.email,
        this.password,
        this.image,
        this.role,
        this.status,
        this.google,
        this.createdAt,
        this.updatedAt,
    });

    factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UserModel.fromDomain(User domainUser) {
      return UserModel(
        id: domainUser.id,
        name: domainUser.name,
        email: domainUser.email,
        // password: domainUser.password, // Domain User doesn't have password
        image: domainUser.image,
        role: domainUser.role == null
            ? null
            : (domainUser.role is String
                ? domainUser.role
                : Role.fromDomain(domainUser.role as UserEntity.Role)),
        status: domainUser.status,
        google: domainUser.google,
        createdAt: domainUser.createdAt,
        updatedAt: domainUser.updatedAt,
      );
    }

    factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        image: json["image"],
        role: json["role"] == null
            ? null
            : (json["role"] is String
                ? json["role"] // Si es un String (ID), lo guardamos como tal
                : Role.fromMap(json["role"])), // Si es un Map, lo convertimos a Role
        status: json["status"],
        google: json["google"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
        "image": image,
        "role": role is Role
            ? (role as Role).toMap() // Si es un Role, lo convertimos a Map
            : role, // Si es un String (ID), lo devolvemos como tal
        "status": status,
        "google": google,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };
}

class Role {
    String? id;
    String? name;
    bool? status;
    bool? deleted;
    String? createdAt;
    String? updatedAt;

    Role({
        this.id,
        this.name,
        this.status,
        this.deleted,
        this.createdAt,
        this.updatedAt,
    });

    factory Role.fromJson(String str) => Role.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Role.fromDomain(UserEntity.Role domainRole) { // Corrected type here
      return Role(
        id: domainRole.id,
        name: domainRole.name,
        status: domainRole.status,
        deleted: domainRole.deleted,
        createdAt: domainRole.createdAt,
        updatedAt: domainRole.updatedAt,
      );
    }

    factory Role.fromMap(Map<String, dynamic> json) => Role(
        id: json["_id"],
        name: json["name"],
        status: json["status"],
        deleted: json["deleted"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "status": status,
        "deleted": deleted,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };
}
