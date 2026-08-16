import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class SignInParams with _$SignInParams {
  const factory SignInParams({
    required String email,
    required String password,
  }) = _SignInParams;
  factory SignInParams.fromJson(Map<String, dynamic> json) =>
      _$SignInParamsFromJson(json);
}

@freezed
abstract class SignUpParams with _$SignUpParams {
  const factory SignUpParams({
    required String email,
    required String password,
  }) = _SignUpParams;
  factory SignUpParams.fromJson(Map<String, dynamic> json) =>
      _$SignUpParamsFromJson(json);
}
