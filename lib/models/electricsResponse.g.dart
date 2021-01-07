// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'electricsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElectricsResponse _$ElectricsResponseFromJson(Map<String, dynamic> json) {
  return ElectricsResponse()
    ..code = json['code'] as num
    ..message = json['message'] as String
    ..data = json['data'] == null
        ? null
        : ElectricsResponseData.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ElectricsResponseToJson(ElectricsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data
    };
