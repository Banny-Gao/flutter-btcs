// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submitGroupResponseData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitGroupResponseData _$SubmitGroupResponseDataFromJson(
    Map<String, dynamic> json) {
  return SubmitGroupResponseData()
    ..currencyName = json['currencyName'] as String
    ..id = json['id'] as num
    ..number = json['number'] as num
    ..summary = json['summary'] as String
    ..serverList = (json['serverList'] as List)
        ?.map((e) =>
            e == null ? null : ServerList.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SubmitGroupResponseDataToJson(
        SubmitGroupResponseData instance) =>
    <String, dynamic>{
      'currencyName': instance.currencyName,
      'id': instance.id,
      'number': instance.number,
      'summary': instance.summary,
      'serverList': instance.serverList
    };
