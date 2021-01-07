// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraw.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Withdraw _$WithdrawFromJson(Map<String, dynamic> json) {
  return Withdraw()
    ..actualMoney = json['actualMoney'] as num
    ..address = json['address'] as String
    ..createTime = json['createTime'] as String
    ..currencyId = json['currencyId'] as num
    ..currencyName = json['currencyName'] as String
    ..id = json['id'] as num
    ..memberId = json['memberId'] as num
    ..memberName = json['memberName'] as String
    ..money = json['money'] as num
    ..opId = json['opId'] as num
    ..opTime = json['opTime'] as String
    ..refReason = json['refReason'] as String
    ..serviceCharge = json['serviceCharge'] as num
    ..status = json['status'] as num
    ..username = json['username'] as String
    ..remark = json['remark'] as String;
}

Map<String, dynamic> _$WithdrawToJson(Withdraw instance) => <String, dynamic>{
      'actualMoney': instance.actualMoney,
      'address': instance.address,
      'createTime': instance.createTime,
      'currencyId': instance.currencyId,
      'currencyName': instance.currencyName,
      'id': instance.id,
      'memberId': instance.memberId,
      'memberName': instance.memberName,
      'money': instance.money,
      'opId': instance.opId,
      'opTime': instance.opTime,
      'refReason': instance.refReason,
      'serviceCharge': instance.serviceCharge,
      'status': instance.status,
      'username': instance.username,
      'remark': instance.remark
    };
