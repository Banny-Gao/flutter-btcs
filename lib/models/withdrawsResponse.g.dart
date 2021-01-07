// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawsResponse _$WithdrawsResponseFromJson(Map<String, dynamic> json) {
  return WithdrawsResponse()
    ..code = json['code'] as num
    ..data = json['data'] == null
        ? null
        : WithdrawsResponseData.fromJson(json['data'] as Map<String, dynamic>)
    ..message = json['message'] as String;
}

Map<String, dynamic> _$WithdrawsResponseToJson(WithdrawsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'message': instance.message
    };
