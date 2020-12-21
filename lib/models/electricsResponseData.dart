import 'package:json_annotation/json_annotation.dart';
import "electricOrder.dart";
part 'electricsResponseData.g.dart';

@JsonSerializable()
class ElectricsResponseData {
    ElectricsResponseData();

    num endRow;
    bool hasNextPage;
    bool hasPreviousPage;
    bool isFirstPage;
    bool isLastPage;
    List<ElectricOrder> list;
    
    factory ElectricsResponseData.fromJson(Map<String,dynamic> json) => _$ElectricsResponseDataFromJson(json);
    Map<String, dynamic> toJson() => _$ElectricsResponseDataToJson(this);
}
