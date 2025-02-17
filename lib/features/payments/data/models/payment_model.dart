import 'dart:convert';
import 'package:cleancode_app/core/domain/entities/user.dart';
import 'package:cleancode_app/features/payment_methods/data/models/payment_method_model.dart';

class PaymentModel {
    String? id;
    String? description;
    String? comments;
    double? amount;
    dynamic paymentMethod;
    dynamic owner;
    bool? status;
    // dynamic creator;
    String? createdAt;
    String? updatedAt;

    PaymentModel({
        this.id,
        this.description,
        this.comments,
        this.amount,
        this.paymentMethod,
        this.owner,
        this.status,
        // this.creator,
        this.createdAt,
        this.updatedAt,
    });

    factory PaymentModel.fromJson(String str) => PaymentModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PaymentModel.fromMap(Map<String, dynamic> json) => PaymentModel(
        id: json["_id"],
        description: json["description"],
        comments: json["comments"],
        amount: json["amount"]?.toDouble(),
        paymentMethod: json["payment_method"] == null ? null : json["payment_method"] is String ? json["payment_method"] : PaymentMethodModel.fromMap(json["payment_method"]),
        owner: json["owner"] == null ? null : json["owner"] is String ? json["owner"] : User.fromMap(json["owner"]),
        status: json["status"],
        // creator: json["creator"] == null ? null : json["creator"] is String ? json["creator"] : User.fromMap(json["creator"]),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "description": description,
        "comments": comments,
        "amount": amount,
        "payment_method": paymentMethod is PaymentMethodModel ? paymentMethod?.toMap() : paymentMethod,
        "owner": owner is User ? owner?.toMap() : owner,
        "status": status,
        // "creator": creator is User ? creator?.toMap() : creator,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };
}