import 'package:json_annotation/json_annotation.dart';
import "submitGroupResponseData.dart";
part 'submitGroupResponse.g.dart';

@JsonSerializable()
class SubmitGroupResponse {
    SubmitGroupResponse();

    num code;
    String message;
    SubmitGroupResponseData data;
    
    factory SubmitGroupResponse.fromJson(Map<String,dynamic> json) => _$SubmitGroupResponseFromJson(json);
    Map<String, dynamic> toJson() => _$SubmitGroupResponseToJson(this);
}
