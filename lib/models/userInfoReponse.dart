import 'package:json_annotation/json_annotation.dart';
import "user.dart";
part 'userInfoReponse.g.dart';

@JsonSerializable()
class UserInfoReponse {
    UserInfoReponse();

    num code;
    User data;
    String message;
    
    factory UserInfoReponse.fromJson(Map<String,dynamic> json) => _$UserInfoReponseFromJson(json);
    Map<String, dynamic> toJson() => _$UserInfoReponseToJson(this);
}
