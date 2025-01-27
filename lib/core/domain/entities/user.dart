import 'dart:convert';

class User {
    String? id;
    String? name;
    String? email;
    String? image;
    Role? role;
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

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        image: json["image"],
        role: json["role"] == null ? null : Role.fromMap(json["role"]),
        status: json["status"],
        google: json["google"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "email": email,
        "image": image,
        "role": role?.toMap(),
        "status": status,
        "google": google,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };
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
