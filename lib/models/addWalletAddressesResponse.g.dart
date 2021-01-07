// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addWalletAddressesResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddWalletAddressesResponse _$AddWalletAddressesResponseFromJson(
    Map<String, dynamic> json) {
  return AddWalletAddressesResponse()
    ..code = json['code'] as num
    ..data = json['data'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$AddWalletAddressesResponseToJson(
        AddWalletAddressesResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'message': instance.message
    };
