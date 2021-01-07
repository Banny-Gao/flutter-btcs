import 'package:json_annotation/json_annotation.dart';
import "dealResponseData.dart";
part 'dealResponse.g.dart';

@JsonSerializable()
class DealResponse {
    DealResponse();

    num code;
    String message;
    DealResponseData data;
    
    factory DealResponse.fromJson(Map<String,dynamic> json) => _$DealResponseFromJson(json);
    Map<String, dynamic> toJson() => _$DealResponseToJson(this);
}
