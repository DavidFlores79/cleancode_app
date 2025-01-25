import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleancode_app/features/users/domain/usecases/get_users_usecase.dart';
import 'package:cleancode_app/features/users/presentation/bloc/user_event.dart';
import 'package:cleancode_app/features/users/presentation/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsersUseCase getUsersUseCase;

  UserBloc({required this.getUsersUseCase}) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
  }

  void _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await getUsersUseCase();
    result.fold(
      (failure) => emit(UserFailure(failure.message)),
      (users) => emit(UserSuccess(users)),
    );
  }
}