// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submitOrderResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitOrderResponse _$SubmitOrderResponseFromJson(Map<String, dynamic> json) {
  return SubmitOrderResponse()
    ..code = json['code'] as num
    ..message = json['message'] as String
    ..data = json['data'] == null
        ? null
        : PaymentInfo.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SubmitOrderResponseToJson(
        SubmitOrderResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data
    };
