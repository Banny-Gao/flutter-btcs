import 'package:json_annotation/json_annotation.dart';

part 'coin.g.dart';

@JsonSerializable()
class Coin {
    Coin();

    String addressQr;
    String chineseName;
    num currencyId;
    String currencyName;
    num dealOpen;
    String iconPath;
    String information;
    num isRollOut;
    num isShiftTo;
    num minLimit;
    String payeeAddress;
    num serviceCharge;
    
    factory Coin.fromJson(Map<String,dynamic> json) => _$CoinFromJson(json);
    Map<String, dynamic> toJson() => _$CoinToJson(this);
}
