// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coin _$CoinFromJson(Map<String, dynamic> json) {
  return Coin()
    ..addressQr = json['addressQr'] as String
    ..chineseName = json['chineseName'] as String
    ..currencyId = json['currencyId'] as num
    ..currencyName = json['currencyName'] as String
    ..dealOpen = json['dealOpen'] as num
    ..iconPath = json['iconPath'] as String
    ..information = json['information'] as String
    ..isRollOut = json['isRollOut'] as num
    ..isShiftTo = json['isShiftTo'] as num
    ..minLimit = json['minLimit'] as num
    ..payeeAddress = json['payeeAddress'] as String
    ..serviceCharge = json['serviceCharge'] as num;
}

Map<String, dynamic> _$CoinToJson(Coin instance) => <String, dynamic>{
      'addressQr': instance.addressQr,
      'chineseName': instance.chineseName,
      'currencyId': instance.currencyId,
      'currencyName': instance.currencyName,
      'dealOpen': instance.dealOpen,
      'iconPath': instance.iconPath,
      'information': instance.information,
      'isRollOut': instance.isRollOut,
      'isShiftTo': instance.isShiftTo,
      'minLimit': instance.minLimit,
      'payeeAddress': instance.payeeAddress,
      'serviceCharge': instance.serviceCharge
    };
