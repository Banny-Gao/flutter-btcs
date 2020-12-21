import 'package:json_annotation/json_annotation.dart';

part 'orderEarnings.g.dart';

@JsonSerializable()
class OrderEarnings {
    OrderEarnings();

    String createTime;
    num earnings;
    num longTime;
    num platformMoney;
    num totalEarnings;
    
    factory OrderEarnings.fromJson(Map<String,dynamic> json) => _$OrderEarningsFromJson(json);
    Map<String, dynamic> toJson() => _$OrderEarningsToJson(this);
}
