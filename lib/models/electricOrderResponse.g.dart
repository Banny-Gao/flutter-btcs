// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'electricOrderResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElectricOrderResponse _$ElectricOrderResponseFromJson(
    Map<String, dynamic> json) {
  return ElectricOrderResponse()
    ..code = json['code'] as num
    ..message = json['message'] as String
    ..data = json['data'] == null
        ? null
        : ElectricOrder.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ElectricOrderResponseToJson(
        ElectricOrderResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data
    };
