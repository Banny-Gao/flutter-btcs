import 'package:json_annotation/json_annotation.dart';

part 'withdraw.g.dart';

@JsonSerializable()
class Withdraw {
    Withdraw();

    num actualMoney;
    String address;
    String createTime;
    num currencyId;
    String currencyName;
    num id;
    num memberId;
    String memberName;
    num money;
    num opId;
    String opTime;
    String refReason;
    num serviceCharge;
    num status;
    String username;
    String remark;
    
    factory Withdraw.fromJson(Map<String,dynamic> json) => _$WithdrawFromJson(json);
    Map<String, dynamic> toJson() => _$WithdrawToJson(this);
}
