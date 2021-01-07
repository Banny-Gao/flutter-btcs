import 'package:json_annotation/json_annotation.dart';
import "userSignResponseData.dart";
part 'userSignResponse.g.dart';

@JsonSerializable()
class UserSignResponse {
    UserSignResponse();

    num code;
    UserSignResponseData data;
    String message;
    
    factory UserSignResponse.fromJson(Map<String,dynamic> json) => _$UserSignResponseFromJson(json);
    Map<String, dynamic> toJson() => _$UserSignResponseToJson(this);
}
