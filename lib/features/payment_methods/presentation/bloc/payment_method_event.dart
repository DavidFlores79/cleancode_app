import 'package:cleancode_app/features/payment_methods/data/models/payment_method_model.dart';

abstract class PaymentMethodEvent {}

class GetAllPaymentMethods implements PaymentMethodEvent {}
class GetOnePaymentMethod implements PaymentMethodEvent {
  final String itemId;
  GetOnePaymentMethod(this.itemId);
}
class CreatePaymentMethod extends PaymentMethodEvent {
  final PaymentMethodModel item;
  CreatePaymentMethod(this.item);
}
class UpdatePaymentMethod extends PaymentMethodEvent {
  final PaymentMethodModel item;
  UpdatePaymentMethod(this.item);
}
class DeletePaymentMethod extends PaymentMethodEvent {
  final String itemId;
  DeletePaymentMethod(this.itemId);
}