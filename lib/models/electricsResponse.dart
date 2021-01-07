import 'package:json_annotation/json_annotation.dart';
import "electricsResponseData.dart";
part 'electricsResponse.g.dart';

@JsonSerializable()
class ElectricsResponse {
    ElectricsResponse();

    num code;
    String message;
    ElectricsResponseData data;
    
    factory ElectricsResponse.fromJson(Map<String,dynamic> json) => _$ElectricsResponseFromJson(json);
    Map<String, dynamic> toJson() => _$ElectricsResponseToJson(this);
}
