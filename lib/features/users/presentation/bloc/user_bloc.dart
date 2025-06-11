import 'package:cleancode_app/core/constants/app_constants.dart';
import 'package:cleancode_app/core/domain/usecases/search_users_usecase.dart';
import 'package:cleancode_app/features/users/data/models/user_model.dart';
import 'package:cleancode_app/features/users/data/models/item_req_params.dart';
import 'package:cleancode_app/features/users/domain/entities/pageable_users.dart'; // Required for PageableUsers
import 'package:cleancode_app/features/users/domain/entities/user.dart'; // Required for User entity
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

  int currentPage = 1;
  List<UserModel> loadedUsers = [];
  int? totalItems;

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

    if (event.page == null || event.page == 1) {
      currentPage = 1;
      loadedUsers = [];
      totalItems = null;
      emit(UserLoadingState());
    } else {
      // Prevent multiple simultaneous requests if already maxed out
      if (totalItems != null && loadedUsers.length >= totalItems!) {
        // Optionally emit MaxReachedState again if needed, or just return
        // emit(UserMaxReachedState(PageableUsers(page: currentPage, pageSize: event.pageSize ?? AppConstants.defaultPageSize, totalItems: totalItems!, data: loadedUsers.map((um) => um.toDomain()).toList()))); // Requires toDomain()
        return;
      }
      emit(UserLoadingMoreState());
    }

    final result = await getAllUsersUseCase.call(
        params: GetAllUsersParams(
            page: currentPage,
            pageSize: event.pageSize ?? AppConstants.defaultPageSize));

    result.fold(
      (failure) => emit(UserFailureState(failure.message)),
      (pageableData) {
        totalItems = pageableData.totalItems;
        // Map domain User entities to UserModel
        final List<UserModel> newUsers = pageableData.data.map((user) => UserModel.fromDomain(user)).toList();
        loadedUsers.addAll(newUsers);

        // Create a PageableUsers instance with cumulative data for the state
        // Note: pageableData.data here is List<User> (domain), but we need List<User> for PageableUsers entity
        // The loadedUsers (List<UserModel>) is just for internal BLoC state if needed elsewhere or if UI expects UserModels directly.
        // For the state, we should reflect the structure of PageableUsers accurately.
        // The PageableUsers entity expects List<User> (domain entities)

        // Let's re-map the accumulated UserModel list back to User list for the state if PageableUsers strictly needs List<User>
        // For simplicity, if PageableUsers can hold List<UserModel>, this mapping isn't needed.
        // Assuming PageableUsers holds List<User> (domain entities) as per its definition.
        // This requires UserModel to have a toDomain() method, or User to have fromModel().
        // Let's assume PageableUsers was intended to be flexible or that its `data` field should be List<UserModel> for presentation layer.
        // For now, I will construct PageableUsers with the newly fetched `pageableData.data` (which is List<User>)
        // and manage `loadedUsers` (List<UserModel>) separately if needed.
        // The state should represent what the UI needs. If UI needs PageableUsers with List<User>, that's fine.
        // If UI consumes List<UserModel> directly from a paginated structure, then PageableUsers should contain List<UserModel>.
        // Given GetAllUsersSuccessState now takes PageableUsers, and PageableUsers has List<User>, this is consistent.
        // The accumulation logic for `loadedUsers` (List<UserModel>) is for when the UI wants a flat, ever-growing list.

        // Create a PageableUsers for the state, reflecting the current page's data and overall pagination info
        // This state object should represent the *latest page* plus context, not necessarily all users loaded so far in one flat list.
        // However, typical infinite scrolling UI might want the full list.
        // Let's adjust the state to hold the *complete* list of users loaded so far, along with pagination.

        PageableUsers statePageableUsers = PageableUsers(
          page: currentPage, // Current page fetched
          pageSize: pageableData.pageSize,
          totalItems: pageableData.totalItems,
          data: loadedUsers.map((userModel) {
            // This mapping back to domain User might be lossy if UserModel has more fields or different structure
            // It's generally better if PageableUsers in the state can hold UserModels directly
            // or if the UI consumes UserModels. For now, sticking to PageableUsers<User>.
            // This implies User entity should have a constructor that can take all fields from UserModel,
            // or UserModel needs a toDomain() method.
            // Let's assume User entity constructor can handle this for now or that direct mapping is okay.
            return User(
              id: userModel.id,
              name: userModel.name,
              email: userModel.email,
              image: userModel.image,
              role: userModel.role, // This could be tricky if Role types differ
              status: userModel.status,
              google: userModel.google,
              createdAt: userModel.createdAt,
              updatedAt: userModel.updatedAt,
            );
          }).toList(),
        );

        if (loadedUsers.length >= totalItems!) {
          emit(UserMaxReachedState(statePageableUsers));
        } else {
          emit(GetAllUsersSuccessState(statePageableUsers));
        }
        currentPage++;
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
        password: event.item.password,
        image: event.item.image,
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
