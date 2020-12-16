import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
    Group();

    num activityDay;
    String beginTime;
    String carePattern;
    num countDownTime;
    String currencyName;
    num discountMoney;
    num electricMoney;
    String endTime;
    String groupName;
    num groupState;
    String hashrate;
    num id;
    String lcd;
    num manageFee;
    String mineFieldName;
    num miningBeginNumber;
    num platformTotal;
    String power;
    String producImg;
    num realityMoney;
    num sellPlatform;
    num stagingTime;
    num theRatio;
    num yieldOutput;
    
    factory Group.fromJson(Map<String,dynamic> json) => _$GroupFromJson(json);
    Map<String, dynamic> toJson() => _$GroupToJson(this);
}
