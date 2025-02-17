import 'package:cleancode_app/features/payment_methods/data/models/payment_method_model.dart';

abstract class PaymentMethodState {}

class PaymentMethodInitialState implements PaymentMethodState {}
class PaymentMethodLoadingState implements PaymentMethodState {}
class GetAllPaymentMethodsSuccessState implements PaymentMethodState {
  final List<PaymentMethodModel> items;
  GetAllPaymentMethodsSuccessState(this.items);
}
class GetOnePaymentMethodSuccessState implements PaymentMethodState {
  final PaymentMethodModel item;
  GetOnePaymentMethodSuccessState(this.item);
}
class UpdatePaymentMethodSuccessState implements PaymentMethodState {
  final PaymentMethodModel item;
  UpdatePaymentMethodSuccessState(this.item);
}
class CreatePaymentMethodSuccessState implements PaymentMethodState {
  final PaymentMethodModel item;
  CreatePaymentMethodSuccessState(this.item);
}
class DeletePaymentMethodSuccessState implements PaymentMethodState {}
class PaymentMethodFailureState implements PaymentMethodState {
  final String message;
  PaymentMethodFailureState(this.message);
}

class ForbiddenActionState extends PaymentMethodState {
  final String message;

  ForbiddenActionState(this.message);
}