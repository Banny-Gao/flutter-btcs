import 'package:json_annotation/json_annotation.dart';
import "orderEarnings.dart";
part 'orderEarningsResponseData.g.dart';

@JsonSerializable()
class OrderEarningsResponseData {
    OrderEarningsResponseData();

    num endRow;
    bool hasNextPage;
    bool hasPreviousPage;
    bool isFirstPage;
    bool isLastPage;
    List<OrderEarnings> list;
    
    factory OrderEarningsResponseData.fromJson(Map<String,dynamic> json) => _$OrderEarningsResponseDataFromJson(json);
    Map<String, dynamic> toJson() => _$OrderEarningsResponseDataToJson(this);
}
