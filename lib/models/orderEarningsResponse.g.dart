// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderEarningsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEarningsResponse _$OrderEarningsResponseFromJson(
    Map<String, dynamic> json) {
  return OrderEarningsResponse()
    ..code = json['code'] as num
    ..message = json['message'] as String
    ..data = json['data'] == null
        ? null
        : OrderEarningsResponseData.fromJson(
            json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$OrderEarningsResponseToJson(
        OrderEarningsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data
    };
