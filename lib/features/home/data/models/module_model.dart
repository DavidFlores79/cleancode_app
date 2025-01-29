import 'dart:convert';
import 'package:cleancode_app/features/home/domain/entities/module.dart';

class ModuleModel extends Module {
    String? id;
    String? name;
    String? route;
    String? image;
    bool? status;
    bool? deleted;
    String? createdAt;
    String? updatedAt;

    ModuleModel({
        this.id,
        this.name,
        this.route,
        this.image,
        this.status,
        this.deleted,
        this.createdAt,
        this.updatedAt,
    });

    factory ModuleModel.fromJson(String str) => ModuleModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ModuleModel.fromMap(Map<String, dynamic> json) => ModuleModel(
        id: json["_id"],
        name: json["name"],
        route: json["route"],
        image: json["image"],
        status: json["status"],
        deleted: json["deleted"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "route": route,
        "image": image,
        "status": status,
        "deleted": deleted,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };
}
