import 'dart:convert';

import 'package:cleancode_app/core/domain/entities/user.dart';

class PaymentMethodModel {
    String? id;
    String? name;
    bool? status;
    dynamic userId;
    String? createdAt;
    String? updatedAt;

    PaymentMethodModel({
        this.id,
        this.name,
        this.status,
        this.userId,
        this.createdAt,
        this.updatedAt,
    });

    factory PaymentMethodModel.fromJson(String str) => PaymentMethodModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PaymentMethodModel.fromMap(Map<String, dynamic> json) => PaymentMethodModel(
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