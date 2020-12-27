import 'package:json_annotation/json_annotation.dart';

part 'coinPrice.g.dart';

@JsonSerializable()
class CoinPrice {
    CoinPrice();

    String createTime;
    num lastPrice;
    String currencyName;
    num marketId;
    num longTime;
    
    factory CoinPrice.fromJson(Map<String,dynamic> json) => _$CoinPriceFromJson(json);
    Map<String, dynamic> toJson() => _$CoinPriceToJson(this);
}
