// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'walletAddress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletAddress _$WalletAddressFromJson(Map<String, dynamic> json) {
  return WalletAddress()
    ..address = json['address'] as String
    ..currencyId = json['currencyId'] as num
    ..currencyName = json['currencyName'] as String
    ..id = json['id'] as num
    ..memberId = json['memberId'] as num;
}

Map<String, dynamic> _$WalletAddressToJson(WalletAddress instance) =>
    <String, dynamic>{
      'address': instance.address,
      'currencyId': instance.currencyId,
      'currencyName': instance.currencyName,
      'id': instance.id,
      'memberId': instance.memberId
    };
