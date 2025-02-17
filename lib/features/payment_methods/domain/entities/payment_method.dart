import 'package:cleancode_app/core/domain/entities/user.dart';

class PaymentMethod {
    String? id;
    String? name;
    bool? status;
    User? userId;
    String? createdAt;
    String? updatedAt;

    PaymentMethod({
        this.id,
        this.name,
        this.status,
        this.userId,
        this.createdAt,
        this.updatedAt,
    });
}