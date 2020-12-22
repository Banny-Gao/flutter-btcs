// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assetsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetsResponse _$AssetsResponseFromJson(Map<String, dynamic> json) {
  return AssetsResponse()
    ..code = json['code'] as num
    ..message = json['message'] as String
    ..data = (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Asset.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$AssetsResponseToJson(AssetsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data
    };
