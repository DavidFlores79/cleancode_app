import 'package:cleancode_app/features/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:cleancode_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleancode_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:cleancode_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:cleancode_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:cleancode_app/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final IsLoggedInUsecase isLoggedInUseCase;

  AuthBloc(
      {required this.loginUseCase,
      required this.registerUseCase,
      required this.logoutUseCase,
      required this.isLoggedInUseCase})
      : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<IsLoggetInRequested>(_onLoggedInRequested);
  }

  void _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginUseCase(event.email, event.password);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) {
        emit(Authenticated());
        emit(AuthSuccess(user));
      },
    );
  }

  void _onRegisterRequested(
      RegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result =
        await registerUseCase(event.name, event.email, event.password);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  void _onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await logoutUseCase();
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (data) => emit(Unauthenticated("salida del sistema")),
    );
  }

  void _onLoggedInRequested(IsLoggetInRequested event, Emitter<AuthState> emit) async {
    // emit(AuthLoading());
    final result = await isLoggedInUseCase();
    if(result) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated('========== no estás autenticado ========'));
    }
  }
}
