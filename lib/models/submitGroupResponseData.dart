import 'package:json_annotation/json_annotation.dart';
import "serverList.dart";
part 'submitGroupResponseData.g.dart';

@JsonSerializable()
class SubmitGroupResponseData {
    SubmitGroupResponseData();

    String currencyName;
    num id;
    num number;
    String summary;
    List<ServerList> serverList;
    
    factory SubmitGroupResponseData.fromJson(Map<String,dynamic> json) => _$SubmitGroupResponseDataFromJson(json);
    Map<String, dynamic> toJson() => _$SubmitGroupResponseDataToJson(this);
}
