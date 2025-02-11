
import 'dart:convert';

class ApiResponse<T> {
    int? page;
    int? pageSize;
    int? totalItems;
    T? data;

    ApiResponse({
        this.page,
        this.pageSize,
        this.totalItems,
        this.data,
    });

    factory ApiResponse.fromJson(String str) => ApiResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ApiResponse.fromMap(Map<String, dynamic> json) => ApiResponse(
        page: json["page"],
        pageSize: json["pageSize"],
        totalItems: json["totalItems"],
    );

    Map<String, dynamic> toMap() => {
        "page": page,
        "pageSize": pageSize,
        "totalItems": totalItems,
    };
}