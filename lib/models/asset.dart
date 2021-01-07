import 'package:json_annotation/json_annotation.dart';

part 'asset.g.dart';

@JsonSerializable()
class Asset {
    Asset();

    num assetsId;
    num currencyId;
    String currencyName;
    num currencyNumber;
    num freezeNumber;
    String iconPath;
    num isRollOut;
    num isShiftTo;
    num minLimit;
    num serviceCharge;
    
    factory Asset.fromJson(Map<String,dynamic> json) => _$AssetFromJson(json);
    Map<String, dynamic> toJson() => _$AssetToJson(this);
}
