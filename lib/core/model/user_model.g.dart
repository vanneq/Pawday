// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  uid: json['uid'] as String,
  email: json['email'] as String,
  emailVerified: json['emailVerified'] as bool,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
    };

_AuthParams _$AuthParamsFromJson(Map<String, dynamic> json) => _AuthParams(
  email: json['email'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$AuthParamsToJson(_AuthParams instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};
