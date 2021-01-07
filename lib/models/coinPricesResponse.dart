import 'package:json_annotation/json_annotation.dart';
import "coinPrice.dart";
part 'coinPricesResponse.g.dart';

@JsonSerializable()
class CoinPricesResponse {
    CoinPricesResponse();

    num code;
    String message;
    List<CoinPrice> data;
    
    factory CoinPricesResponse.fromJson(Map<String,dynamic> json) => _$CoinPricesResponseFromJson(json);
    Map<String, dynamic> toJson() => _$CoinPricesResponseToJson(this);
}
