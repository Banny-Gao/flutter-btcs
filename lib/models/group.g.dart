// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) {
  return Group()
    ..activityDayL = json['activityDayL'] as num
    ..beginTime = json['beginTime'] as String
    ..carePattern = json['carePattern'] as String
    ..countDownTime = json['countDownTime'] as num
    ..currencyName = json['currencyName'] as String
    ..discountMoney = json['discountMoney'] as num
    ..electricMoney = json['electricMoney'] as num
    ..endTime = json['endTime'] as String
    ..groupName = json['groupName'] as String
    ..groupState = json['groupState'] as num
    ..hashrate = json['hashrate'] as String
    ..id = json['id'] as num
    ..lcd = json['lcd'] as String
    ..manageFee = json['manageFee'] as num
    ..mineFieldName = json['mineFieldName'] as String
    ..miningBeginNumber = json['miningBeginNumber'] as num
    ..platformTotal = json['platformTotal'] as num
    ..power = json['power'] as String
    ..producImg = json['producImg'] as String
    ..realityMoney = json['realityMoney'] as num
    ..sellPlatform = json['sellPlatform'] as num
    ..stagingTime = json['stagingTime'] as num
    ..theRatio = json['theRatio'] as num
    ..yieldOutput = json['yieldOutput'] as num;
}

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'activityDayL': instance.activityDayL,
      'beginTime': instance.beginTime,
      'carePattern': instance.carePattern,
      'countDownTime': instance.countDownTime,
      'currencyName': instance.currencyName,
      'discountMoney': instance.discountMoney,
      'electricMoney': instance.electricMoney,
      'endTime': instance.endTime,
      'groupName': instance.groupName,
      'groupState': instance.groupState,
      'hashrate': instance.hashrate,
      'id': instance.id,
      'lcd': instance.lcd,
      'manageFee': instance.manageFee,
      'mineFieldName': instance.mineFieldName,
      'miningBeginNumber': instance.miningBeginNumber,
      'platformTotal': instance.platformTotal,
      'power': instance.power,
      'producImg': instance.producImg,
      'realityMoney': instance.realityMoney,
      'sellPlatform': instance.sellPlatform,
      'stagingTime': instance.stagingTime,
      'theRatio': instance.theRatio,
      'yieldOutput': instance.yieldOutput
    };
