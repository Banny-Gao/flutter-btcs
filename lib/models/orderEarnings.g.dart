// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderEarnings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEarnings _$OrderEarningsFromJson(Map<String, dynamic> json) {
  return OrderEarnings()
    ..createTime = json['createTime'] as String
    ..earnings = json['earnings'] as num
    ..longTime = json['longTime'] as num
    ..platformMoney = json['platformMoney'] as num
    ..totalEarnings = json['totalEarnings'] as num;
}

Map<String, dynamic> _$OrderEarningsToJson(OrderEarnings instance) =>
    <String, dynamic>{
      'createTime': instance.createTime,
      'earnings': instance.earnings,
      'longTime': instance.longTime,
      'platformMoney': instance.platformMoney,
      'totalEarnings': instance.totalEarnings
    };
