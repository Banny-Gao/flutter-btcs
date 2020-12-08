import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
    User();

    num autoStatus;
    String inviteCode;
    String memberAvatar;
    String memberName;
    String memberPhone;
    String memberSex;
    num passwdState;
    num payPwdState;
    
    factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toJson() => _$UserToJson(this);
}
