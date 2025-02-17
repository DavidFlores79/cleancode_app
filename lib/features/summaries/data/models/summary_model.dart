import 'dart:convert';
import 'package:cleancode_app/core/domain/entities/user.dart';

class SummaryModel {
    String? image;
    String? id;
    String? title;
    String? comments;
    dynamic owner;
    bool? status;
    dynamic creator;
    String? createdAt;
    String? updatedAt;

    SummaryModel({
        this.image,
        this.id,
        this.title,
        this.comments,
        this.owner,
        this.status,
        this.creator,
        this.createdAt,
        this.updatedAt,
    });

    factory SummaryModel.fromJson(String str) => SummaryModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SummaryModel.fromMap(Map<String, dynamic> json) => SummaryModel(
        image: json["image"],
        id: json["_id"],
        title: json["title"],
        comments: json["comments"],
        owner: json["owner"] == null ? null : json["owner"] is String ? json["owner"] :  User.fromMap(json["owner"]),
        status: json["status"],
        creator: json["creator"] == null ? null : json["creator"] is String ? json["creator"] : User.fromMap(json["creator"]),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toMap() => {
        "image": image,
        "_id": id,
        "title": title,
        "comments": comments,
        "owner": owner is User ? owner?.toMap() : owner,
        "status": status,
        "creator": creator is User ? creator?.toMap() : creator,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };
}