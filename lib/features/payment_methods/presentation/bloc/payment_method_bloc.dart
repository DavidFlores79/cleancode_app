import 'package:cleancode_app/features/payment_methods/data/models/payment_method_model.dart';
import 'package:cleancode_app/features/payment_methods/data/models/item_req_params.dart';
import 'package:cleancode_app/features/payment_methods/domain/usecases/create_payment_method_usecase.dart';
import 'package:cleancode_app/features/payment_methods/domain/usecases/delete_payment_method_usecase.dart';
import 'package:cleancode_app/features/payment_methods/domain/usecases/update_payment_method_usecase.dart';
import 'package:cleancode_app/features/payment_methods/domain/usecases/get_all_payment_methods_usecase.dart';
import 'package:cleancode_app/features/payment_methods/domain/usecases/get_one_payment_method_usecase.dart';
import 'package:cleancode_app/features/payment_methods/presentation/bloc/payment_method_event.dart';
import 'package:cleancode_app/features/payment_methods/presentation/bloc/payment_method_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  final GetAllPaymentMethodsUsecase getAllPaymentMethodsUseCase;
  final GetOnePaymentMethodUsecase getOnePaymentMethodUseCase;
  final CreatePaymentMethodUsecase createPaymentMethodUseCase;
  final UpdatePaymentMethodUsecase updatePaymentMethodUseCase;
  final DeletePaymentMethodUsecase deletePaymentMethodUseCase;

  PaymentMethodBloc({
    required this.getAllPaymentMethodsUseCase,
    required this.getOnePaymentMethodUseCase,
    required this.createPaymentMethodUseCase,
    required this.updatePaymentMethodUseCase,
    required this.deletePaymentMethodUseCase,
  }) : super(PaymentMethodInitialState()) {
    on<GetAllPaymentMethods>(_onGetAllPaymentMethods);
    on<GetOnePaymentMethod>(_onGetOnePaymentMethod);
    on<CreatePaymentMethod>(_onCreatePaymentMethod);
    on<UpdatePaymentMethod>(_onUpdatePaymentMethod);
    on<DeletePaymentMethod>(_onDeletePaymentMethod);
  }

  void _onGetAllPaymentMethods(
      GetAllPaymentMethods event, Emitter<PaymentMethodState> emit) async {
    emit(PaymentMethodLoadingState());
    final result = await getAllPaymentMethodsUseCase();
    result.fold(
      (failure) => emit(PaymentMethodFailureState(failure)),
      (data) {
        debugPrint(data.data['data'].toString());
        final List<PaymentMethodModel> paymentMethods =
            (data.data?['data'] as List<dynamic>)
                .map((json) => PaymentMethodModel.fromMap(json))
                .toList();
        emit(GetAllPaymentMethodsSuccessState(paymentMethods));
      },
    );
  }

  void _onGetOnePaymentMethod(
      GetOnePaymentMethod event, Emitter<PaymentMethodState> emit) async {
    emit(PaymentMethodLoadingState());
    final result = await getOnePaymentMethodUseCase.call(
        params: PaymentMethodReqParams(id: event.itemId));
    result.fold(
      (failure) => emit(PaymentMethodFailureState(failure)),
      (data) {
        emit(
          GetOnePaymentMethodSuccessState(
            PaymentMethodModel.fromMap(
              data.data['data'],
            ),
          ),
        );
      },
    );
  }

  void _onCreatePaymentMethod(
      CreatePaymentMethod event, Emitter<PaymentMethodState> emit) async {
    emit(PaymentMethodLoadingState());
    final result = await createPaymentMethodUseCase.call(
      params: PaymentMethodReqParams(
        id: '',
        name: event.item.name,
        status: event.item.status,
      ),
    );
    result.fold(
      (failure) => emit(PaymentMethodFailureState(failure)),
      (data) {
        emit(CreatePaymentMethodSuccessState(PaymentMethodModel.fromMap(
            data.data['data'],
        )));
      }, // Recargar la lista después de crear
    );
  }

  void _onUpdatePaymentMethod(
      UpdatePaymentMethod event, Emitter<PaymentMethodState> emit) async {
    emit(PaymentMethodLoadingState());
    final result = await updatePaymentMethodUseCase.call(
        params: PaymentMethodReqParams(
      id: event.item.id!,
      name: event.item.name!,
      status: event.item.status!,
    ));
    result.fold(
      (failure) => emit(PaymentMethodFailureState(failure)),
      (data) {
        emit(UpdatePaymentMethodSuccessState(PaymentMethodModel.fromMap(
            data.data['data'],
        )));
      }, // Recargar la lista después de actualizar
    );
  }

  void _onDeletePaymentMethod(
      DeletePaymentMethod event, Emitter<PaymentMethodState> emit) async {
    emit(PaymentMethodLoadingState());
    final result = await deletePaymentMethodUseCase(params: PaymentMethodReqParams(id: event.itemId));
    result.fold(
      (failure) => emit(PaymentMethodFailureState(failure)),
      (_) {
        emit(DeletePaymentMethodSuccessState());
      }, // Recargar la lista después de eliminar
    );
  }
}
