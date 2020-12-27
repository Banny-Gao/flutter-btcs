// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coinPrice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinPrice _$CoinPriceFromJson(Map<String, dynamic> json) {
  return CoinPrice()
    ..createTime = json['createTime'] as String
    ..lastPrice = json['lastPrice'] as num
    ..currencyName = json['currencyName'] as String
    ..marketId = json['marketId'] as num
    ..longTime = json['longTime'] as num;
}

Map<String, dynamic> _$CoinPriceToJson(CoinPrice instance) => <String, dynamic>{
      'createTime': instance.createTime,
      'lastPrice': instance.lastPrice,
      'currencyName': instance.currencyName,
      'marketId': instance.marketId,
      'longTime': instance.longTime
    };
