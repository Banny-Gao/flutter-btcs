// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capitalLogsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CapitalLogsResponse _$CapitalLogsResponseFromJson(Map<String, dynamic> json) {
  return CapitalLogsResponse()
    ..code = json['code'] as num
    ..message = json['message'] as String
    ..data = json['data'] == null
        ? null
        : CapitalLogsResponseData.fromJson(
            json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CapitalLogsResponseToJson(
        CapitalLogsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data
    };
