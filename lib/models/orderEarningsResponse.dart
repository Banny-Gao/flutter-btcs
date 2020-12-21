import 'package:json_annotation/json_annotation.dart';
import "orderEarningsResponseData.dart";
part 'orderEarningsResponse.g.dart';

@JsonSerializable()
class OrderEarningsResponse {
    OrderEarningsResponse();

    num code;
    String message;
    OrderEarningsResponseData data;
    
    factory OrderEarningsResponse.fromJson(Map<String,dynamic> json) => _$OrderEarningsResponseFromJson(json);
    Map<String, dynamic> toJson() => _$OrderEarningsResponseToJson(this);
}
