// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userInfoReponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoReponse _$UserInfoReponseFromJson(Map<String, dynamic> json) {
  return UserInfoReponse()
    ..code = json['code'] as num
    ..data = json['data'] == null
        ? null
        : User.fromJson(json['data'] as Map<String, dynamic>)
    ..message = json['message'] as String;
}

Map<String, dynamic> _$UserInfoReponseToJson(UserInfoReponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'message': instance.message
    };
