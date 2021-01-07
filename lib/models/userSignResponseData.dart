import 'package:json_annotation/json_annotation.dart';

part 'userSignResponseData.g.dart';

@JsonSerializable()
class UserSignResponseData {
    UserSignResponseData();

    String token;
    String phone;
    
    factory UserSignResponseData.fromJson(Map<String,dynamic> json) => _$UserSignResponseDataFromJson(json);
    Map<String, dynamic> toJson() => _$UserSignResponseDataToJson(this);
}
