// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serverList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerList _$ServerListFromJson(Map<String, dynamic> json) {
  return ServerList()
    ..chargeWay = json['chargeWay'] as String
    ..costType = json['costType'] as String
    ..number = json['number'] as String
    ..price = json['price'] as String
    ..serveProduct = json['serveProduct'] as String
    ..serviceName = json['serviceName'] as String
    ..subtotal = json['subtotal'] as String;
}

Map<String, dynamic> _$ServerListToJson(ServerList instance) =>
    <String, dynamic>{
      'chargeWay': instance.chargeWay,
      'costType': instance.costType,
      'number': instance.number,
      'price': instance.price,
      'serveProduct': instance.serveProduct,
      'serviceName': instance.serviceName,
      'subtotal': instance.subtotal
    };
