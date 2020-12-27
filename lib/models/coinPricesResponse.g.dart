// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coinPricesResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinPricesResponse _$CoinPricesResponseFromJson(Map<String, dynamic> json) {
  return CoinPricesResponse()
    ..code = json['code'] as num
    ..message = json['message'] as String
    ..data = (json['data'] as List)
        ?.map((e) =>
            e == null ? null : CoinPrice.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CoinPricesResponseToJson(CoinPricesResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data
    };
