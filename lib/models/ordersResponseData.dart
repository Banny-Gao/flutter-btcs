import 'package:json_annotation/json_annotation.dart';
import "orders.dart";
part 'ordersResponseData.g.dart';

@JsonSerializable()
class OrdersResponseData {
    OrdersResponseData();

    num endRow;
    bool hasNextPage;
    bool hasPreviousPage;
    bool isFirstPage;
    bool isLastPage;
    List<Orders> list;
    
    factory OrdersResponseData.fromJson(Map<String,dynamic> json) => _$OrdersResponseDataFromJson(json);
    Map<String, dynamic> toJson() => _$OrdersResponseDataToJson(this);
}
