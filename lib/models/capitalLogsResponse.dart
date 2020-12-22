import 'package:json_annotation/json_annotation.dart';
import "capitalLogsResponseData.dart";
part 'capitalLogsResponse.g.dart';

@JsonSerializable()
class CapitalLogsResponse {
    CapitalLogsResponse();

    num code;
    String message;
    CapitalLogsResponseData data;
    
    factory CapitalLogsResponse.fromJson(Map<String,dynamic> json) => _$CapitalLogsResponseFromJson(json);
    Map<String, dynamic> toJson() => _$CapitalLogsResponseToJson(this);
}
