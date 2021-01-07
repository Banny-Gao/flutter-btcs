// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uploadResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadResponse _$UploadResponseFromJson(Map<String, dynamic> json) {
  return UploadResponse()
    ..code = json['code'] as num
    ..data = json['data'] == null
        ? null
        : UploadResponseData.fromJson(json['data'] as Map<String, dynamic>)
    ..message = json['message'] as String;
}

Map<String, dynamic> _$UploadResponseToJson(UploadResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'message': instance.message
    };
