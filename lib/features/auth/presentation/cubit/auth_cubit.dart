import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kotik/core/failure/result.dart';
import 'package:kotik/features/auth/domain/usecases/login_usecase.dart';
import 'package:kotik/features/auth/domain/usecases/logout_usecase.dart';
import 'package:kotik/features/auth/domain/usecases/register_usecase.dart';
import 'package:kotik/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;

  AuthCubit({
    required this.registerUseCase,
    required this.loginUseCase,
    required this.logoutUseCase,
  }) : super(const AuthState.initial());

  Future<void> register(
    String email,
    String password,
    String confirmPassword,
  ) async {
    emit(AuthState.loading());

    final result = await registerUseCase(email, password, confirmPassword);
    switch (result) {
      case Success(data: final user):
        emit(AuthState.authenticated(user: user));

      case Failure(:final message):
        emit(AuthState.error(message));
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthState.loading());

    final result = await loginUseCase(email, password);
    switch (result) {
      case Success(data: final user):
        emit(AuthState.authenticated(user: user));

      case Failure(:final message):
        emit(AuthState.error(message));
    }
  }

  Future<void> logOut() async {
    emit(AuthState.loading());

    final result = await logoutUseCase();
    switch (result) {
      case Success():
        emit(AuthState.unauthenticated());

      case Failure(:final message):
        emit(AuthState.error(message));
    }
  }
}
