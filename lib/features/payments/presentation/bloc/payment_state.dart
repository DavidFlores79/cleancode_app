import 'package:cleancode_app/features/payments/data/models/payment_model.dart';

abstract class PaymentState {}

class PaymentInitialState implements PaymentState {}
class PaymentLoadingState implements PaymentState {}
class GetAllPaymentsSuccessState implements PaymentState {
  final List<PaymentModel> items;
  GetAllPaymentsSuccessState(this.items);
}
class GetOnePaymentSuccessState implements PaymentState {
  final PaymentModel item;
  GetOnePaymentSuccessState(this.item);
}
class UpdatePaymentSuccessState implements PaymentState {
  final PaymentModel item;
  UpdatePaymentSuccessState(this.item);
}
class CreatePaymentSuccessState implements PaymentState {
  final PaymentModel item;
  CreatePaymentSuccessState(this.item);
}
class DeletePaymentSuccessState implements PaymentState {}
class PaymentFailureState implements PaymentState {
  final String message;
  PaymentFailureState(this.message);
}

class ForbiddenActionState extends PaymentState {
  final String message;

  ForbiddenActionState(this.message);
}