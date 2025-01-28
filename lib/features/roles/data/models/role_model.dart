import 'dart:convert';

import 'package:cleancode_app/core/domain/entities/user.dart';

class RoleModel extends Role {
    String? id;
    String? name;
    bool? status;
    String? createdAt;
    String? updatedAt;

    RoleModel({
        this.id,
        this.name,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

  factory RoleModel.fromJson(String str) => RoleModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RoleModel.fromMap(Map<String, dynamic> json) => RoleModel(
        id: json["_id"],
        name: json["name"],
        status: json["status"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "status": status,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
