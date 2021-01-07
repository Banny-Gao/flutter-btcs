// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hashRate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HashRate _$HashRateFromJson(Map<String, dynamic> json) {
  return HashRate()
    ..createTime = json['createTime'] as String
    ..currencyId = json['currencyId'] as num
    ..hashrate = json['hashrate'] as num
    ..id = json['id'] as num
    ..longTime = json['longTime'] as String
    ..varCreateTime = json['varCreateTime'] as String;
}

Map<String, dynamic> _$HashRateToJson(HashRate instance) => <String, dynamic>{
      'createTime': instance.createTime,
      'currencyId': instance.currencyId,
      'hashrate': instance.hashrate,
      'id': instance.id,
      'longTime': instance.longTime,
      'varCreateTime': instance.varCreateTime
    };
