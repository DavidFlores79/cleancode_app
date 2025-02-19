import 'package:cleancode_app/features/payment_methods/data/models/payment_method_model.dart';
import 'package:cleancode_app/features/users/data/models/user_model.dart';

class PaymentReqParams {
  final String id;
  final String? description;
  final dynamic paymentMethod;
  final String? comments;
  final dynamic owner;
  final double? amount;
  final bool? status;

  PaymentReqParams({required this.id, this.description, this.status, this.comments, this.amount, this.paymentMethod, this.owner});

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      '_id': id,
      'owner': owner is UserModel ? UserModel.fromMap(owner).id : owner,
      'description': description,
      'payment_method': paymentMethod is PaymentMethodModel ? PaymentMethodModel.fromMap(paymentMethod).id : paymentMethod,
      'comments': comments,
      'amount': amount,
      'status': status,
    };
  }
}