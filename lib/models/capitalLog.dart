import 'package:json_annotation/json_annotation.dart';

part 'capitalLog.g.dart';

@JsonSerializable()
class CapitalLog {
    CapitalLog();

    String createTime;
    String currencyIconPath;
    String currencyName;
    num id;
    num logStatus;
    num money;
    num type;
    
    factory CapitalLog.fromJson(Map<String,dynamic> json) => _$CapitalLogFromJson(json);
    Map<String, dynamic> toJson() => _$CapitalLogToJson(this);
}
