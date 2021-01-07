import 'package:json_annotation/json_annotation.dart';
import "capitalLog.dart";
part 'capitalLogsResponseData.g.dart';

@JsonSerializable()
class CapitalLogsResponseData {
    CapitalLogsResponseData();

    num endRow;
    bool hasNextPage;
    bool hasPreviousPage;
    bool isFirstPage;
    bool isLastPage;
    List<CapitalLog> list;
    
    factory CapitalLogsResponseData.fromJson(Map<String,dynamic> json) => _$CapitalLogsResponseDataFromJson(json);
    Map<String, dynamic> toJson() => _$CapitalLogsResponseDataToJson(this);
}
