// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymentInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentInfo _$PaymentInfoFromJson(Map<String, dynamic> json) {
  return PaymentInfo()
    ..buyNumber = json['buyNumber'] as num
    ..countDownTime = json['countDownTime'] as num
    ..createTime = json['createTime'] as String
    ..currencyIconPath = json['currencyIconPath'] as String
    ..currencyName = json['currencyName'] as String
    ..lcd = json['lcd'] as String
    ..money = json['money'] as num
    ..orderNumber = json['orderNumber'] as String
    ..payQr = json['payQr'] as String
    ..topAddress = json['topAddress'] as String;
}

Map<String, dynamic> _$PaymentInfoToJson(PaymentInfo instance) =>
    <String, dynamic>{
      'buyNumber': instance.buyNumber,
      'countDownTime': instance.countDownTime,
      'createTime': instance.createTime,
      'currencyIconPath': instance.currencyIconPath,
      'currencyName': instance.currencyName,
      'lcd': instance.lcd,
      'money': instance.money,
      'orderNumber': instance.orderNumber,
      'payQr': instance.payQr,
      'topAddress': instance.topAddress
    };
