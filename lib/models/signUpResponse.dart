import 'package:json_annotation/json_annotation.dart';
import "signUpResponseData.dart";
part 'signUpResponse.g.dart';

@JsonSerializable()
class SignUpResponse {
    SignUpResponse();

    num code;
    SignUpResponseData data;
    String message;
    
    factory SignUpResponse.fromJson(Map<String,dynamic> json) => _$SignUpResponseFromJson(json);
    Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);
}
