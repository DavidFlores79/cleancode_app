import 'package:cleancode_app/features/roles/domain/usecases/get_roles_usecase.dart';
import 'package:cleancode_app/features/roles/presentation/bloc/role_event.dart';
import 'package:cleancode_app/features/roles/presentation/bloc/role_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  final GetRolesUsecase getRolesUserCase;

  RoleBloc({required this.getRolesUserCase}): super(RoleInitialState()) {
    on<FetchRoles>(_onFetchRoles);
  }
  
  void _onFetchRoles(FetchRoles event, Emitter<RoleState> emit) async {
    emit(RoleLoadingState());

    final result = await getRolesUserCase();
    result.fold(
      (failure) {
        debugPrint('Bloc ${failure.message}');
        if(failure.message.contains('403')) {
          return emit(ForbiddenActionState(failure.message));
        }
        return emit(RoleFailureState(failure.message));
      },
      (data) => emit(RoleSuccessState(data)),
    );
  }
}