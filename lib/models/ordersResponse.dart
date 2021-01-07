import 'package:json_annotation/json_annotation.dart';
import "ordersResponseData.dart";
part 'ordersResponse.g.dart';

@JsonSerializable()
class OrdersResponse {
    OrdersResponse();

    num code;
    String message;
    OrdersResponseData data;
    
    factory OrdersResponse.fromJson(Map<String,dynamic> json) => _$OrdersResponseFromJson(json);
    Map<String, dynamic> toJson() => _$OrdersResponseToJson(this);
}
