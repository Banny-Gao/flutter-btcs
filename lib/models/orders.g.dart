// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Orders _$OrdersFromJson(Map<String, dynamic> json) {
  return Orders()
    ..awaitElectricity = json['awaitElectricity'] as num
    ..buyNumber = json['buyNumber'] as num
    ..causeStatus = json['causeStatus'] as num
    ..createTime = json['createTime'] as String
    ..currencyIconPath = json['currencyIconPath'] as String
    ..currencyName = json['currencyName'] as String
    ..energyStatus = json['energyStatus'] as num
    ..groupName = json['groupName'] as String
    ..id = json['id'] as num
    ..lcd = json['lcd'] as String
    ..memberId = json['memberId'] as num
    ..miningEndTime = json['miningEndTime'] as String
    ..money = json['money'] as num
    ..orderNumber = json['orderNumber'] as String
    ..paymentNumber = json['paymentNumber'] as num
    ..producImg = json['producImg'] as String
    ..robotStatus = json['robotStatus'] as num
    ..status = json['status'] as num
    ..surplusMoney = json['surplusMoney'] as num
    ..totalEarnings = json['totalEarnings'] as num;
}

Map<String, dynamic> _$OrdersToJson(Orders instance) => <String, dynamic>{
      'awaitElectricity': instance.awaitElectricity,
      'buyNumber': instance.buyNumber,
      'causeStatus': instance.causeStatus,
      'createTime': instance.createTime,
      'currencyIconPath': instance.currencyIconPath,
      'currencyName': instance.currencyName,
      'energyStatus': instance.energyStatus,
      'groupName': instance.groupName,
      'id': instance.id,
      'lcd': instance.lcd,
      'memberId': instance.memberId,
      'miningEndTime': instance.miningEndTime,
      'money': instance.money,
      'orderNumber': instance.orderNumber,
      'paymentNumber': instance.paymentNumber,
      'producImg': instance.producImg,
      'robotStatus': instance.robotStatus,
      'status': instance.status,
      'surplusMoney': instance.surplusMoney,
      'totalEarnings': instance.totalEarnings
    };
