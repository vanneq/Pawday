import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kotik/core/model/user/user_model.dart';
part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.error(String error) = AuthError;
  const factory AuthState.authenticated({required UserModel user}) =
      AuthAuthenticated;
  const factory AuthState.unauthenticated() = AuthUnauthenticated;
}
