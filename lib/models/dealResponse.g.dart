// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dealResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DealResponse _$DealResponseFromJson(Map<String, dynamic> json) {
  return DealResponse()
    ..code = json['code'] as num
    ..message = json['message'] as String
    ..data = json['data'] == null
        ? null
        : DealResponseData.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DealResponseToJson(DealResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data
    };
