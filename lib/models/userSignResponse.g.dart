// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userSignResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSignResponse _$UserSignResponseFromJson(Map<String, dynamic> json) {
  return UserSignResponse()
    ..code = json['code'] as num
    ..data = json['data'] == null
        ? null
        : UserSignResponseData.fromJson(json['data'] as Map<String, dynamic>)
    ..message = json['message'] as String;
}

Map<String, dynamic> _$UserSignResponseToJson(UserSignResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'message': instance.message
    };
