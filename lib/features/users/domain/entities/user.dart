import 'dart:convert';

class User {
    String? id;
    String? name;
    String? email;
    String? image;
    dynamic role;
    bool? status;
    bool? google;
    String? createdAt;
    String? updatedAt;

    User({
        this.id,
        this.name,
        this.email,
        this.image,
        this.role,
        this.status,
        this.google,
        this.createdAt,
        this.updatedAt,
    });
}

class Role {
    String? id;
    String? name;
    bool? status;
    bool? deleted;
    String? createdAt;
    String? updatedAt;

    Role({
        this.id,
        this.name,
        this.status,
        this.deleted,
        this.createdAt,
        this.updatedAt,
    });

    factory Role.fromJson(String str) => Role.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Role.fromMap(Map<String, dynamic> json) => Role(
        id: json["_id"],
        name: json["name"],
        status: json["status"],
        deleted: json["deleted"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "status": status,
        "deleted": deleted,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };
}
