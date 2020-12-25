import 'package:json_annotation/json_annotation.dart';
import "hashRate.dart";
part 'hashRateResponse.g.dart';

@JsonSerializable()
class HashRateResponse {
    HashRateResponse();

    num code;
    String message;
    List<HashRate> data;
    
    factory HashRateResponse.fromJson(Map<String,dynamic> json) => _$HashRateResponseFromJson(json);
    Map<String, dynamic> toJson() => _$HashRateResponseToJson(this);
}
