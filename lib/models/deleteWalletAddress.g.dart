// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deleteWalletAddress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteWalletAddress _$DeleteWalletAddressFromJson(Map<String, dynamic> json) {
  return DeleteWalletAddress()
    ..code = json['code'] as num
    ..data = json['data'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$DeleteWalletAddressToJson(
        DeleteWalletAddress instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'message': instance.message
    };
