import 'dart:convert';

import 'package:cleancode_app/core/domain/entities/user.dart';

class PosterModel {
    String? id;
    String? name;
    String? image;
    String? audio;
    String? authors;
    String? code;
    String? contactEmail;
    CategoryModel? category;
    bool? status;
    User? userId;
    String? createdAt;
    String? updatedAt;

    PosterModel({
        this.id,
        this.name,
        this.image,
        this.audio,
        this.authors,
        this.code,
        this.contactEmail,
        this.category,
        this.status,
        this.userId,
        this.createdAt,
        this.updatedAt,
    });

    factory PosterModel.fromJson(String str) => PosterModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PosterModel.fromMap(Map<String, dynamic> json) => PosterModel(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        audio: json["audio"],
        authors: json["authors"],
        code: json["code"],
        contactEmail: json["contactEmail"],
        category: json["category"] == null ? null : CategoryModel.fromMap(json["category"]),
        status: json["status"],
        userId: json["user_id"] == null ? null : User.fromMap(json["user_id"]),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "image": image,
        "audio": audio,
        "authors": authors,
        "code": code,
        "contactEmail": contactEmail,
        "category": category?.toMap(),
        "status": status,
        "user_id": userId?.toMap(),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };
}

class CategoryModel {
    String? id;
    String? name;
    bool? status;
    bool? deleted;
    String? userId;
    String? createdAt;
    String? updatedAt;

    CategoryModel({
        this.id,
        this.name,
        this.status,
        this.deleted,
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
        deleted: json["deleted"],
        userId: json["user_id"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "status": status,
        "deleted": deleted,
        "user_id": userId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };
}