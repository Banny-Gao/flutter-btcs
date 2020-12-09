// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'changeUserInfoResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeUserInfoResponse _$ChangeUserInfoResponseFromJson(
    Map<String, dynamic> json) {
  return ChangeUserInfoResponse()
    ..code = json['code'] as num
    ..message = json['message'] as String
    ..data = json['data'] as String;
}

Map<String, dynamic> _$ChangeUserInfoResponseToJson(
        ChangeUserInfoResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data
    };
