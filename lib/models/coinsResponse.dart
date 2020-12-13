import 'package:json_annotation/json_annotation.dart';
import "coin.dart";
part 'coinsResponse.g.dart';

@JsonSerializable()
class CoinsResponse {
    CoinsResponse();

    num code;
    String message;
    List<Coin> data;
    
    factory CoinsResponse.fromJson(Map<String,dynamic> json) => _$CoinsResponseFromJson(json);
    Map<String, dynamic> toJson() => _$CoinsResponseToJson(this);
}
