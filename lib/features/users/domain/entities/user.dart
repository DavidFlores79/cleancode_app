import 'dart:convert';
import 'package:flutter/foundation.dart'; // For listEquals and mapEquals if needed, or just for @override

class User {
    String? id;
    String? name;
    String? email;
    String? image;
    dynamic role;
    bool? status;
    bool? google;
    String? createdAt;
    String? updatedAt;

    User({
        this.id,
        this.name,
        this.email,
        this.image,
        this.role,
        this.status,
        this.google,
        this.createdAt,
        this.updatedAt,
    });

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        image: json["image"],
        role: json["role"] == null
            ? null
            : (json["role"] is Map<String, dynamic>
                ? Role.fromMap(json["role"])
                : json["role"]), // If not a map, assume it's an ID or primitive
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
        "role": role == null
            ? null
            : (role is Role ? role.toMap() : (role is Map<String, dynamic> ? role : role)),
        "status": status,
        "google": google,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.image == image &&
      other.role.toString() == role.toString() && // Basic toString comparison for dynamic role
      other.status == status &&
      other.google == google &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      image.hashCode ^
      role.hashCode ^ // Basic hashCode for dynamic role
      status.hashCode ^
      google.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Role &&
      other.id == id &&
      other.name == name &&
      other.status == status &&
      other.deleted == deleted &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      status.hashCode ^
      deleted.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
