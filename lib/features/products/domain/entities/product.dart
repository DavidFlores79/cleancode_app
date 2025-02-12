import 'dart:convert';
import 'package:cleancode_app/core/domain/entities/user.dart';
class ProductEntity {
    String? id;
    String? name;
    String? image;
    String? audio;
    String? authors;
    String? code;
    String? contactEmail;
    dynamic category;
    bool? status;
    dynamic userId;
    String? createdAt;
    String? updatedAt;

    ProductEntity({
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
}
class CategoryEntity {
    String? image;
    String? color;
    String? id;
    String? name;
    bool? status;
    bool? deleted;
    dynamic userId;
    String? createdAt;
    String? updatedAt;

    CategoryEntity({
        this.image,
        this.color,
        this.id,
        this.name,
        this.status,
        this.deleted,
        this.userId,
        this.createdAt,
        this.updatedAt,
    });

    factory CategoryEntity.fromJson(String str) => CategoryEntity.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CategoryEntity.fromMap(Map<String, dynamic> json) => CategoryEntity(
        image: json["image"],
        color: json["color"],
        id: json["_id"],
        name: json["name"],
        status: json["status"],
        deleted: json["deleted"],
        userId: json["user_id"] == null ? null : json['user_id'] is String ? json['user_id'] : User.fromMap(json["user_id"]),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toMap() => {
        "image": image,
        "color": color,
        "_id": id,
        "name": name,
        "status": status,
        "deleted": deleted,
        "user_id": userId is User ? userId?.toMap() : userId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };
}
