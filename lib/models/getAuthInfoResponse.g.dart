// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getAuthInfoResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAuthInfoResponse _$GetAuthInfoResponseFromJson(Map<String, dynamic> json) {
  return GetAuthInfoResponse()
    ..code = json['code'] as num
    ..message = json['message'] as String
    ..data = json['data'] == null
        ? null
        : AuthInfo.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GetAuthInfoResponseToJson(
        GetAuthInfoResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data
    };
