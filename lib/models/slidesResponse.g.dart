// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slidesResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlidesResponse _$SlidesResponseFromJson(Map<String, dynamic> json) {
  return SlidesResponse()
    ..code = json['code'] as num
    ..data = json['data'] == null
        ? null
        : SlidesResponseData.fromJson(json['data'] as Map<String, dynamic>)
    ..message = json['message'] as String;
}

Map<String, dynamic> _$SlidesResponseToJson(SlidesResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'message': instance.message
    };
