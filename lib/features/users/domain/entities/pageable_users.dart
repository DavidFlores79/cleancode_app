import 'package:cleancode_app/features/users/domain/entities/user.dart';
import 'package:flutter/foundation.dart';

class PageableUsers {
  final int page;
  final int pageSize;
  final int totalItems;
  final List<User> data;

  PageableUsers({
    required this.page,
    required this.pageSize,
    required this.totalItems,
    required this.data,
  });

  PageableUsers copyWith({
    int? page,
    int? pageSize,
    int? totalItems,
    List<User>? data,
  }) {
    return PageableUsers(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      totalItems: totalItems ?? this.totalItems,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'pageSize': pageSize,
      'totalItems': totalItems,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory PageableUsers.fromMap(Map<String, dynamic> map) {
    return PageableUsers(
      page: map['page']?.toInt() ?? 0,
      pageSize: map['pageSize']?.toInt() ?? 0,
      totalItems: map['totalItems']?.toInt() ?? 0,
      data: List<User>.from(map['data']?.map((x) => User.fromMap(x)) ?? const []),
    );
  }

  @override
  String toString() {
    return 'PageableUsers(page: $page, pageSize: $pageSize, totalItems: $totalItems, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PageableUsers &&
      other.page == page &&
      other.pageSize == pageSize &&
      other.totalItems == totalItems &&
      listEquals(other.data, data);
  }

  @override
  int get hashCode {
    return page.hashCode ^
      pageSize.hashCode ^
      totalItems.hashCode ^
      data.hashCode;
  }
}
