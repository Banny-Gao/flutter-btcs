// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capitalLog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CapitalLog _$CapitalLogFromJson(Map<String, dynamic> json) {
  return CapitalLog()
    ..createTime = json['createTime'] as String
    ..currencyIconPath = json['currencyIconPath'] as String
    ..currencyName = json['currencyName'] as String
    ..id = json['id'] as num
    ..logStatus = json['logStatus'] as num
    ..money = json['money'] as num
    ..type = json['type'] as num;
}

Map<String, dynamic> _$CapitalLogToJson(CapitalLog instance) =>
    <String, dynamic>{
      'createTime': instance.createTime,
      'currencyIconPath': instance.currencyIconPath,
      'currencyName': instance.currencyName,
      'id': instance.id,
      'logStatus': instance.logStatus,
      'money': instance.money,
      'type': instance.type
    };
