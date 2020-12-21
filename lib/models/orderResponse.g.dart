// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) {
  return OrderResponse()
    ..code = json['code'] as num
    ..message = json['message'] as String
    ..data = json['data'] == null
        ? null
        : Orders.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$OrderResponseToJson(OrderResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data
    };
