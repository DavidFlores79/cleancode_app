import 'dart:convert';

import 'package:cleancode_app/core/domain/entities/user.dart';

class CategoryModel {
    String? id;
    String? name;
    bool? status;
    dynamic userId;
    String? createdAt;
    String? updatedAt;

    CategoryModel({
        this.id,
        this.name,
        this.status,
        this.userId,
        this.createdAt,
        this.updatedAt,
    });

    factory CategoryModel.fromJson(String str) => CategoryModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
        id: json["_id"],
        name: json["name"],
        status: json["status"],
        userId: json["user_id"] == null ? null : json["user_id"] is String ? json["user_id"] : User.fromMap(json["user_id"]),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "status": status,
        "user_id": userId is User ? userId?.toMap() : userId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };
}