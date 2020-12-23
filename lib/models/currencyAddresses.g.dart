// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currencyAddresses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyAddresses _$CurrencyAddressesFromJson(Map<String, dynamic> json) {
  return CurrencyAddresses()
    ..code = json['code'] as num
    ..message = json['message'] as String
    ..data = (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : WalletAddress.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CurrencyAddressesToJson(CurrencyAddresses instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data
    };
