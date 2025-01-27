import 'dart:convert';

import 'package:cleancode_app/core/domain/entities/user.dart';

class AuthResponse {
    String? msg;
    User? user;
    String? jwt;

    AuthResponse({
        this.msg,
        this.user,
        this.jwt,
    });

    factory AuthResponse.fromJson(String str) => AuthResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AuthResponse.fromMap(Map<String, dynamic> json) => AuthResponse(
        msg: json["msg"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        jwt: json["jwt"],
    );

    Map<String, dynamic> toMap() => {
        "msg": msg,
        "user": user?.toMap(),
        "jwt": jwt,
    };
}