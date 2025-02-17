import 'package:cleancode_app/features/payments/data/models/payment_model.dart';

abstract class PaymentEvent {}

class GetAllPayments implements PaymentEvent {}
class GetOnePayment implements PaymentEvent {
  final String itemId;
  GetOnePayment(this.itemId);
}
class CreatePayment extends PaymentEvent {
  final PaymentModel item;
  CreatePayment(this.item);
}
class UpdatePayment extends PaymentEvent {
  final PaymentModel item;
  UpdatePayment(this.item);
}
class DeletePayment extends PaymentEvent {
  final String itemId;
  DeletePayment(this.itemId);
}