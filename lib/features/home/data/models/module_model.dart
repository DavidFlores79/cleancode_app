import 'dart:convert';

class ModuleData {
    String? id;
    Module? module;
    List<String>? permissions;
    String? role;
    String? createdAt;
    String? updatedAt;

    ModuleData({
        this.id,
        this.module,
        this.permissions,
        this.role,
        this.createdAt,
        this.updatedAt,
    });

    factory ModuleData.fromJson(String str) => ModuleData.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ModuleData.fromMap(Map<String, dynamic> json) => ModuleData(
        id: json["_id"],
        module: json["module"] == null ? null : Module.fromMap(json["module"]),
        permissions: json["permissions"] == null ? [] : List<String>.from(json["permissions"]!.map((x) => x)),
        role: json["role"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "module": module?.toMap(),
        "permissions": permissions == null ? [] : List<dynamic>.from(permissions!.map((x) => x)),
        "role": role,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };
}

class Module {
    String? id;
    String? name;
    String? route;
    String? image;
    bool? status;
    bool? deleted;
    String? createdAt;
    String? updatedAt;

    Module({
        this.id,
        this.name,
        this.route,
        this.image,
        this.status,
        this.deleted,
        this.createdAt,
        this.updatedAt,
    });

    factory Module.fromJson(String str) => Module.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Module.fromMap(Map<String, dynamic> json) => Module(
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
