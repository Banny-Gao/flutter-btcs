import 'package:json_annotation/json_annotation.dart';
import "group.dart";
part 'groupsResponse.g.dart';

@JsonSerializable()
class GroupsResponse {
    GroupsResponse();

    num code;
    String message;
    List<Group> data;
    
    factory GroupsResponse.fromJson(Map<String,dynamic> json) => _$GroupsResponseFromJson(json);
    Map<String, dynamic> toJson() => _$GroupsResponseToJson(this);
}
