import 'package:json_annotation/json_annotation.dart';

part 'authInfo.g.dart';

@JsonSerializable()
class AuthInfo {
    AuthInfo();

    String backImage;
    String createTime;
    String frontImage;
    String handheldImage;
    num id;
    String idCardNum;
    String btcAddress;
    String ethAddress;
    String usdtAddress;
    num memberId;
    String name;
    String refuseReason;
    num sex;
    num status;
    String updateTime;
    String validityEndTime;
    String validityStartTime;

    factory AuthInfo.fromJson(Map<String,dynamic> json) => _$AuthInfoFromJson(json);
    Map<String, dynamic> toJson() => _$AuthInfoToJson(this);
}
