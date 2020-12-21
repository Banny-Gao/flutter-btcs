// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'electricOrder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElectricOrder _$ElectricOrderFromJson(Map<String, dynamic> json) {
  return ElectricOrder()
    ..createTime = json['createTime'] as String
    ..currencyIconPath = json['currencyIconPath'] as String
    ..currencyName = json['currencyName'] as String
    ..electricOrderNumber = json['electricOrderNumber'] as String
    ..money = json['money'] as num
    ..orderStatus = json['orderStatus'] as num
    ..payAddress = json['payAddress'] as String
    ..payQr = json['payQr'] as String
    ..currencyId = json['currencyId'] as num;
}

Map<String, dynamic> _$ElectricOrderToJson(ElectricOrder instance) =>
    <String, dynamic>{
      'createTime': instance.createTime,
      'currencyIconPath': instance.currencyIconPath,
      'currencyName': instance.currencyName,
      'electricOrderNumber': instance.electricOrderNumber,
      'money': instance.money,
      'orderStatus': instance.orderStatus,
      'payAddress': instance.payAddress,
      'payQr': instance.payQr,
      'currencyId': instance.currencyId
    };
