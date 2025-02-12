import 'dart:convert';
import 'package:cleancode_app/core/domain/entities/user.dart';
import 'package:cleancode_app/features/products/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    super.id, 
    super.name, 
    super.code,
    super.image,
    super.audio,
    super.authors,
    super.contactEmail,
    super.category,
    super.status,
    super.userId,
    super.createdAt,
    super.updatedAt,
  });

  factory ProductModel.fromJson(String str) => ProductModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        audio: json["audio"],
        authors: json["authors"],
        code: json["code"],
        contactEmail: json["contactEmail"],
        category: json["category"] == null ? null : Category.fromMap(json["category"]),
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