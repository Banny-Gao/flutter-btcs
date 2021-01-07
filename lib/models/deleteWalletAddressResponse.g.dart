// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deleteWalletAddressResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteWalletAddressResponse _$DeleteWalletAddressResponseFromJson(
    Map<String, dynamic> json) {
  return DeleteWalletAddressResponse()
    ..code = json['code'] as num
    ..data = json['data'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$DeleteWalletAddressResponseToJson(
        DeleteWalletAddressResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'message': instance.message
    };
