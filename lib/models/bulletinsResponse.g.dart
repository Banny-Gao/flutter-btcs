// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulletinsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BulletinsResponse _$BulletinsResponseFromJson(Map<String, dynamic> json) {
  return BulletinsResponse()
    ..code = json['code'] as num
    ..data = json['data'] == null
        ? null
        : BulletinsResponseData.fromJson(json['data'] as Map<String, dynamic>)
    ..message = json['message'] as String;
}

Map<String, dynamic> _$BulletinsResponseToJson(BulletinsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'message': instance.message
    };
