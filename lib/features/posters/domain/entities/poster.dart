import 'dart:convert';
import 'package:cleancode_app/core/domain/entities/user.dart';

class Poster {
    String? id;
    String? name;
    String? image;
    String? audio;
    String? authors;
    String? code;
    String? contactEmail;
    PosterCategory? category;
    bool? status;
    User? userId;
    String? createdAt;
    String? updatedAt;

    Poster({
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

    factory Poster.fromJson(String str) => Poster.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Poster.fromMap(Map<String, dynamic> json) => Poster(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        audio: json["audio"],
        authors: json["authors"],
        code: json["code"],
        contactEmail: json["contactEmail"],
        category: json["category"] == null ? null : PosterCategory.fromMap(json["category"]),
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

class PosterCategory {
    String? id;
    String? name;
    bool? status;
    bool? deleted;
    String? userId;
    String? createdAt;
    String? updatedAt;

    PosterCategory({
        this.id,
        this.name,
        this.status,
        this.deleted,
        this.userId,
        this.createdAt,
        this.updatedAt,
    });

    factory PosterCategory.fromJson(String str) => PosterCategory.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PosterCategory.fromMap(Map<String, dynamic> json) => PosterCategory(
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