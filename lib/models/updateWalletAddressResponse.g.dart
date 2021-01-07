// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'updateWalletAddressResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateWalletAddressResponse _$UpdateWalletAddressResponseFromJson(
    Map<String, dynamic> json) {
  return UpdateWalletAddressResponse()
    ..code = json['code'] as num
    ..data = json['data'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$UpdateWalletAddressResponseToJson(
        UpdateWalletAddressResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'message': instance.message
    };
