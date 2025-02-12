import 'dart:convert';

import 'package:cleancode_app/core/domain/entities/user.dart';

class Product {
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

    Product({
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

    factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        audio: json["audio"],
        authors: json["authors"],
        code: json["code"],
        contactEmail: json["contactEmail"],
        category: json["category"] == null ? null : json["category"] is String ? json["category"] : Category.fromMap(json["category"]),
        status: json["status"],
        userId: json["user_id"] == null ? null : json['user_id'] is String ? json['user_id'] : User.fromMap(json["user_id"]),
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
        "category": category is Category ? category?.toMap() : category,
        "status": status,
        "user_id": userId is User ? userId?.toMap() : userId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };
}

class Category {
    String? image;
    String? color;
    String? id;
    String? name;
    bool? status;
    bool? deleted;
    String? userId;
    String? createdAt;
    String? updatedAt;

    Category({
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

    factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Category.fromMap(Map<String, dynamic> json) => Category(
        image: json["image"],
        color: json["color"],
        id: json["_id"],
        name: json["name"],
        status: json["status"],
        deleted: json["deleted"],
        userId: json["user_id"],
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
        "user_id": userId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };
}
