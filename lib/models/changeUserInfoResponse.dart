import 'package:json_annotation/json_annotation.dart';

part 'changeUserInfoResponse.g.dart';

@JsonSerializable()
class ChangeUserInfoResponse {
    ChangeUserInfoResponse();

    num code;
    String message;
    String data;
    
    factory ChangeUserInfoResponse.fromJson(Map<String,dynamic> json) => _$ChangeUserInfoResponseFromJson(json);
    Map<String, dynamic> toJson() => _$ChangeUserInfoResponseToJson(this);
}
