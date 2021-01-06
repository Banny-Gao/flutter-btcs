import 'package:json_annotation/json_annotation.dart';
import "authInfo.dart";
part 'getAuthInfoResponse.g.dart';

@JsonSerializable()
class GetAuthInfoResponse {
    GetAuthInfoResponse();

    num code;
    String message;
    AuthInfo data;
    
    factory GetAuthInfoResponse.fromJson(Map<String,dynamic> json) => _$GetAuthInfoResponseFromJson(json);
    Map<String, dynamic> toJson() => _$GetAuthInfoResponseToJson(this);
}
