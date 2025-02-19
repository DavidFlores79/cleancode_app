import 'package:cleancode_app/features/payments/data/models/payment_model.dart';
import 'package:cleancode_app/features/payments/data/models/item_req_params.dart';
import 'package:cleancode_app/features/payments/domain/usecases/create_payment_usecase.dart';
import 'package:cleancode_app/features/payments/domain/usecases/delete_payment_usecase.dart';
import 'package:cleancode_app/features/payments/domain/usecases/update_payment_usecase.dart';
import 'package:cleancode_app/features/payments/domain/usecases/get_all_payments_usecase.dart';
import 'package:cleancode_app/features/payments/domain/usecases/get_one_payment_usecase.dart';
import 'package:cleancode_app/features/payments/presentation/bloc/payment_event.dart';
import 'package:cleancode_app/features/payments/presentation/bloc/payment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final GetAllPaymentsUsecase getAllPaymentsUseCase;
  final GetOnePaymentUsecase getOnePaymentUseCase;
  final CreatePaymentUsecase createPaymentUseCase;
  final UpdatePaymentUsecase updatePaymentUseCase;
  final DeletePaymentUsecase deletePaymentUseCase;

  PaymentBloc({
    required this.getAllPaymentsUseCase,
    required this.getOnePaymentUseCase,
    required this.createPaymentUseCase,
    required this.updatePaymentUseCase,
    required this.deletePaymentUseCase,
  }) : super(PaymentInitialState()) {
    on<GetAllPayments>(_onGetAllPayments);
    on<GetOnePayment>(_onGetOnePayment);
    on<CreatePayment>(_onCreatePayment);
    on<UpdatePayment>(_onUpdatePayment);
    on<DeletePayment>(_onDeletePayment);
  }

  void _onGetAllPayments(
      GetAllPayments event, Emitter<PaymentState> emit) async {
    emit(PaymentLoadingState());
    final result = await getAllPaymentsUseCase();
    result.fold(
      (failure) => emit(PaymentFailureState(failure)),
      (data) {
        debugPrint(data.data['data'].toString());
        final List<PaymentModel> payments =
            (data.data?['data'] as List<dynamic>)
                .map((json) => PaymentModel.fromMap(json))
                .toList();
        emit(GetAllPaymentsSuccessState(payments));
      },
    );
  }

  void _onGetOnePayment(GetOnePayment event, Emitter<PaymentState> emit) async {
    emit(PaymentLoadingState());
    final result = await getOnePaymentUseCase.call(
        query: PaymentReqParams(id: event.itemId));
    result.fold(
      (failure) => emit(PaymentFailureState(failure)),
      (data) {
        emit(
          GetOnePaymentSuccessState(
            PaymentModel.fromMap(
              data.data['data'],
            ),
          ),
        );
      },
    );
  }

  void _onCreatePayment(CreatePayment event, Emitter<PaymentState> emit) async {
    emit(PaymentLoadingState());
    final result = await createPaymentUseCase.call(
      query: PaymentReqParams(
        id: '',
        description: event.item.description,
        paymentMethod: event.item.paymentMethod,
        amount: event.item.amount,
        owner: event.item.owner,
        comments: event.item.comments,
        status: event.item.status,
      ),
    );
    result.fold(
      (failure) => emit(PaymentFailureState(failure)),
      (data) {
        emit(CreatePaymentSuccessState(PaymentModel.fromMap(
          data.data['data'],
        )));
      }, // Recargar la lista después de crear
    );
  }

  void _onUpdatePayment(UpdatePayment event, Emitter<PaymentState> emit) async {
    emit(PaymentLoadingState());
    final result = await updatePaymentUseCase.call(
        query: PaymentReqParams(
      id: event.item.id!,
      description: event.item.description!,
      paymentMethod: event.item.paymentMethod,
      amount: event.item.amount,
      owner: event.item.owner,
      comments: event.item.comments!,
      status: event.item.status!,
    ));
    result.fold(
      (failure) => emit(PaymentFailureState(failure)),
      (data) {
        emit(UpdatePaymentSuccessState(PaymentModel.fromMap(
          data.data['data'],
        )));
      }, // Recargar la lista después de actualizar
    );
  }

  void _onDeletePayment(DeletePayment event, Emitter<PaymentState> emit) async {
    emit(PaymentLoadingState());
    final result =
        await deletePaymentUseCase(query: PaymentReqParams(id: event.itemId));
    result.fold(
      (failure) => emit(PaymentFailureState(failure)),
      (_) {
        emit(DeletePaymentSuccessState());
      }, // Recargar la lista después de eliminar
    );
  }
}
