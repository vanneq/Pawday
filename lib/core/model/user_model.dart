import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String uid,
    required String email,
    required bool emailVerified,
  }) = _UserModel;
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
abstract class AuthParams with _$AuthParams {
  const factory AuthParams({required String email, required String password}) =
      _AuthParams;
  factory AuthParams.fromJson(Map<String, dynamic> json) =>
      _$AuthParamsFromJson(json);
}
