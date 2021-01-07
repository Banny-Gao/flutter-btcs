import 'package:json_annotation/json_annotation.dart';
import "orders.dart";
part 'orderResponse.g.dart';

@JsonSerializable()
class OrderResponse {
    OrderResponse();

    num code;
    String message;
    Orders data;
    
    factory OrderResponse.fromJson(Map<String,dynamic> json) => _$OrderResponseFromJson(json);
    Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}
