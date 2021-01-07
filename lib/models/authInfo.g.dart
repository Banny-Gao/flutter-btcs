// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthInfo _$AuthInfoFromJson(Map<String, dynamic> json) {
  return AuthInfo()
    ..backImage = json['backImage'] as String
    ..createTime = json['createTime'] as String
    ..frontImage = json['frontImage'] as String
    ..handheldImage = json['handheldImage'] as String
    ..id = json['id'] as num
    ..idCardNum = json['idCardNum'] as String
    ..memberId = json['memberId'] as num
    ..name = json['name'] as String
    ..refuseReason = json['refuseReason'] as String
    ..sex = json['sex'] as num
    ..status = json['status'] as num
    ..updateTime = json['updateTime'] as String
    ..validityEndTime = json['validityEndTime'] as String
    ..validityStartTime = json['validityStartTime'] as String;
}

Map<String, dynamic> _$AuthInfoToJson(AuthInfo instance) => <String, dynamic>{
      'backImage': instance.backImage,
      'createTime': instance.createTime,
      'frontImage': instance.frontImage,
      'handheldImage': instance.handheldImage,
      'id': instance.id,
      'idCardNum': instance.idCardNum,
      'memberId': instance.memberId,
      'name': instance.name,
      'refuseReason': instance.refuseReason,
      'sex': instance.sex,
      'status': instance.status,
      'updateTime': instance.updateTime,
      'validityEndTime': instance.validityEndTime,
      'validityStartTime': instance.validityStartTime
    };
