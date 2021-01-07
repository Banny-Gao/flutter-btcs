import 'package:json_annotation/json_annotation.dart';
import "helpClassificationsResponseData.dart";
part 'helpClassificationsResponse.g.dart';

@JsonSerializable()
class HelpClassificationsResponse {
    HelpClassificationsResponse();

    num code;
    HelpClassificationsResponseData data;
    String message;
    
    factory HelpClassificationsResponse.fromJson(Map<String,dynamic> json) => _$HelpClassificationsResponseFromJson(json);
    Map<String, dynamic> toJson() => _$HelpClassificationsResponseToJson(this);
}
