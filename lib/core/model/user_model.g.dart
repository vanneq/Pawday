// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignInParams _$SignInParamsFromJson(Map<String, dynamic> json) =>
    _SignInParams(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SignInParamsToJson(_SignInParams instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};

_SignUpParams _$SignUpParamsFromJson(Map<String, dynamic> json) =>
    _SignUpParams(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SignUpParamsToJson(_SignUpParams instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};
