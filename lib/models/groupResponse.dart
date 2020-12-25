import 'package:json_annotation/json_annotation.dart';
import "group.dart";
part 'groupResponse.g.dart';

@JsonSerializable()
class GroupResponse {
    GroupResponse();

    num code;
    String message;
    Group data;
    
    factory GroupResponse.fromJson(Map<String,dynamic> json) => _$GroupResponseFromJson(json);
    Map<String, dynamic> toJson() => _$GroupResponseToJson(this);
}
