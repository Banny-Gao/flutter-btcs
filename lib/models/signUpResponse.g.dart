// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signUpResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpResponse _$SignUpResponseFromJson(Map<String, dynamic> json) {
  return SignUpResponse()
    ..code = json['code'] as num
    ..data = json['data'] == null
        ? null
        : SignUpResponseData.fromJson(json['data'] as Map<String, dynamic>)
    ..message = json['message'] as String;
}

Map<String, dynamic> _$SignUpResponseToJson(SignUpResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'message': instance.message
    };
