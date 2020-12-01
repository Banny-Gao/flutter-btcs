import 'package:json_annotation/json_annotation.dart';

part 'signUpResponseData.g.dart';

@JsonSerializable()
class SignUpResponseData {
    SignUpResponseData();

    String token;
    String phone;
    
    factory SignUpResponseData.fromJson(Map<String,dynamic> json) => _$SignUpResponseDataFromJson(json);
    Map<String, dynamic> toJson() => _$SignUpResponseDataToJson(this);
}
