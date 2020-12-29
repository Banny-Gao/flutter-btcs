import 'package:json_annotation/json_annotation.dart';

part 'hashRate.g.dart';

@JsonSerializable()
class HashRate {
    HashRate();

    String createTime;
    num currencyId;
    num hashrate;
    num id;
    String longTime;
    String varCreateTime;
    
    factory HashRate.fromJson(Map<String,dynamic> json) => _$HashRateFromJson(json);
    Map<String, dynamic> toJson() => _$HashRateToJson(this);
}
