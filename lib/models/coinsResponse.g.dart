// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coinsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinsResponse _$CoinsResponseFromJson(Map<String, dynamic> json) {
  return CoinsResponse()
    ..code = json['code'] as num
    ..message = json['message'] as String
    ..data = (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Coin.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CoinsResponseToJson(CoinsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data
    };
