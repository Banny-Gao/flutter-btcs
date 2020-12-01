// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responseBasic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseBasic _$ResponseBasicFromJson(Map<String, dynamic> json) {
  return ResponseBasic()
    ..code = json['code'] as num
    ..data = json['data'] as Map<String, dynamic>
    ..message = json['message'] as String;
}

Map<String, dynamic> _$ResponseBasicToJson(ResponseBasic instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'message': instance.message
    };
