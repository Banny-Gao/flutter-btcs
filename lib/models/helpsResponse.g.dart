// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helpsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HelpsResponse _$HelpsResponseFromJson(Map<String, dynamic> json) {
  return HelpsResponse()
    ..code = json['code'] as num
    ..message = json['message'] as String
    ..data = json['data'] == null
        ? null
        : HelpsData.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$HelpsResponseToJson(HelpsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data
    };
