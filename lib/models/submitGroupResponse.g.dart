// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submitGroupResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitGroupResponse _$SubmitGroupResponseFromJson(Map<String, dynamic> json) {
  return SubmitGroupResponse()
    ..code = json['code'] as num
    ..message = json['message'] as String
    ..data = json['data'] == null
        ? null
        : SubmitGroupResponseData.fromJson(
            json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SubmitGroupResponseToJson(
        SubmitGroupResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data
    };
