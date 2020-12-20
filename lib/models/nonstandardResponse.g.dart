// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nonstandardResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NonstandardResponse _$NonstandardResponseFromJson(Map<String, dynamic> json) {
  return NonstandardResponse()
    ..code = json['code'] as num
    ..message = json['message'] as String
    ..data = json['data'] as String;
}

Map<String, dynamic> _$NonstandardResponseToJson(
        NonstandardResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data
    };
