// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymentInfoResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentInfoResponse _$PaymentInfoResponseFromJson(Map<String, dynamic> json) {
  return PaymentInfoResponse()
    ..code = json['code'] as num
    ..message = json['message'] as String
    ..data = json['data'] == null
        ? null
        : PaymentInfo.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PaymentInfoResponseToJson(
        PaymentInfoResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data
    };
