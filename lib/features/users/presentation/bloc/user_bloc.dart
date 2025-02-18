import 'package:cleancode_app/core/domain/usecases/search_users_usecase.dart';
import 'package:cleancode_app/features/users/data/models/user_model.dart';
import 'package:cleancode_app/features/users/data/models/item_req_params.dart';
import 'package:cleancode_app/features/users/domain/usecases/create_user_usecase.dart';
import 'package:cleancode_app/features/users/domain/usecases/delete_user_usecase.dart';
import 'package:cleancode_app/features/users/domain/usecases/update_user_usecase.dart';
import 'package:cleancode_app/features/users/domain/usecases/get_all_users_usecase.dart';
import 'package:cleancode_app/features/users/domain/usecases/get_one_user_usecase.dart';
import 'package:cleancode_app/features/users/presentation/bloc/user_event.dart';
import 'package:cleancode_app/features/users/presentation/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetAllUsersUsecase getAllUsersUseCase;
  final GetOneUserUsecase getOneUserUseCase;
  final CreateUserUsecase createUserUseCase;
  final UpdateUserUsecase updateUserUseCase;
  final DeleteUserUsecase deleteUserUseCase;
  final SearchUsersUsecase searchUsersUsecase;

  UserBloc({
    required this.getAllUsersUseCase,
    required this.getOneUserUseCase,
    required this.createUserUseCase,
    required this.updateUserUseCase,
    required this.deleteUserUseCase,
    required this.searchUsersUsecase,
  }) : super(UserInitialState()) {
    on<GetAllUsers>(_onGetAllUsers);
    on<GetOneUser>(_onGetOneUser);
    on<CreateUser>(_onCreateUser);
    on<UpdateUser>(_onUpdateUser);
    on<DeleteUser>(_onDeleteUser);
    on<SearchUsers>(_onSearchUsers);
  }

  void _onGetAllUsers(
      GetAllUsers event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    final result = await getAllUsersUseCase();
    result.fold(
      (failure) => emit(UserFailureState(failure)),
      (data) {
        debugPrint(data.data['data'].toString());
        final List<UserModel> users =
            (data.data?['data'] as List<dynamic>)
                .map((json) => UserModel.fromMap(json))
                .toList();
        emit(GetAllUsersSuccessState(users));
      },
    );
  }

  void _onGetOneUser(GetOneUser event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    final result = await getOneUserUseCase.call(
        query: UserReqParams(id: event.itemId));
    result.fold(
      (failure) => emit(UserFailureState(failure)),
      (data) {
        emit(
          GetOneUserSuccessState(
            UserModel.fromMap(
              data.data['data'],
            ),
          ),
        );
      },
    );
  }

  void _onCreateUser(CreateUser event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    final result = await createUserUseCase.call(
      query: UserReqParams(
        id: '',
        name: event.item.name,
        email: event.item.email,
        image: event.item.image,
        role: event.item.role,
        status: event.item.status,
      ),
    );
    result.fold(
      (failure) => emit(UserFailureState(failure)),
      (data) {
        emit(CreateUserSuccessState(UserModel.fromMap(
          data.data['data'],
        )));
      }, // Recargar la lista después de crear
    );
  }

  void _onUpdateUser(UpdateUser event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    final result = await updateUserUseCase.call(
        query: UserReqParams(
      id: event.item.id!,
      name: event.item.name,
        email: event.item.email,
        image: event.item.image,
        role: event.item.role,
        status: event.item.status,
    ));
    result.fold(
      (failure) => emit(UserFailureState(failure)),
      (data) {
        emit(UpdateUserSuccessState(UserModel.fromMap(
          data.data['data'],
        )));
      }, // Recargar la lista después de actualizar
    );
  }

  void _onDeleteUser(DeleteUser event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    final result =
        await deleteUserUseCase(query: UserReqParams(id: event.itemId));
    result.fold(
      (failure) => emit(UserFailureState(failure)),
      (_) {
        emit(DeleteUserSuccessState());
      }, // Recargar la lista después de eliminar
    );
  }

  void _onSearchUsers(
      SearchUsers event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    final result = await searchUsersUsecase(query: event.query);
    result.fold(
      (failure) => emit(UserFailureState(failure)),
      (data) {
        final List<UserModel> users =
            (data.data?['data'] as List<dynamic>)
                .map((json) => UserModel.fromMap(json))
                .toList();
        emit(SearchUsersSuccessState(users));
      },
    );
  }
}
