// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'walletAddressesResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletAddressesResponse _$WalletAddressesResponseFromJson(
    Map<String, dynamic> json) {
  return WalletAddressesResponse()
    ..code = json['code'] as num
    ..data = json['data'] == null
        ? null
        : WalletAddressesResponseData.fromJson(
            json['data'] as Map<String, dynamic>)
    ..message = json['message'] as String;
}

Map<String, dynamic> _$WalletAddressesResponseToJson(
        WalletAddressesResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'message': instance.message
    };
