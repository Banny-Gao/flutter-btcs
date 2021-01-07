// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hashRateResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HashRateResponse _$HashRateResponseFromJson(Map<String, dynamic> json) {
  return HashRateResponse()
    ..code = json['code'] as num
    ..message = json['message'] as String
    ..data = (json['data'] as List)
        ?.map((e) =>
            e == null ? null : HashRate.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$HashRateResponseToJson(HashRateResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data
    };
