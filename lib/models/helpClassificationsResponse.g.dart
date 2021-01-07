// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helpClassificationsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HelpClassificationsResponse _$HelpClassificationsResponseFromJson(
    Map<String, dynamic> json) {
  return HelpClassificationsResponse()
    ..code = json['code'] as num
    ..data = json['data'] == null
        ? null
        : HelpClassificationsResponseData.fromJson(
            json['data'] as Map<String, dynamic>)
    ..message = json['message'] as String;
}

Map<String, dynamic> _$HelpClassificationsResponseToJson(
        HelpClassificationsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'message': instance.message
    };
