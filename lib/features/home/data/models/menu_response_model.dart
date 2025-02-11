import 'dart:convert';

import 'package:cleancode_app/features/home/data/models/module_model.dart';

class MenuResponse {
    List<Datum>? data;

    MenuResponse({
        this.data,
    });

    factory MenuResponse.fromJson(String str) => MenuResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MenuResponse.fromMap(Map<String, dynamic> json) => MenuResponse(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class Datum {
    String? id;
    ModuleModel? module;
    String? role;
    DateTime? createdAt;
    DateTime? updatedAt;

    Datum({
        this.id,
        this.module,
        this.role,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        module: json["module"] == null ? null : ModuleModel.fromMap(json["module"]),
        role: json["role"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "module": module?.toMap(),
        "role": role,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}