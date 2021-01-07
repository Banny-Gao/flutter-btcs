// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Asset _$AssetFromJson(Map<String, dynamic> json) {
  return Asset()
    ..assetsId = json['assetsId'] as num
    ..currencyId = json['currencyId'] as num
    ..currencyName = json['currencyName'] as String
    ..currencyNumber = json['currencyNumber'] as num
    ..freezeNumber = json['freezeNumber'] as num
    ..iconPath = json['iconPath'] as String
    ..isRollOut = json['isRollOut'] as num
    ..isShiftTo = json['isShiftTo'] as num
    ..minLimit = json['minLimit'] as num
    ..serviceCharge = json['serviceCharge'] as num;
}

Map<String, dynamic> _$AssetToJson(Asset instance) => <String, dynamic>{
      'assetsId': instance.assetsId,
      'currencyId': instance.currencyId,
      'currencyName': instance.currencyName,
      'currencyNumber': instance.currencyNumber,
      'freezeNumber': instance.freezeNumber,
      'iconPath': instance.iconPath,
      'isRollOut': instance.isRollOut,
      'isShiftTo': instance.isShiftTo,
      'minLimit': instance.minLimit,
      'serviceCharge': instance.serviceCharge
    };
