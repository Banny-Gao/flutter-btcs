import 'package:json_annotation/json_annotation.dart';

part 'helpClassifications.g.dart';

@JsonSerializable()
class HelpClassifications {
    HelpClassifications();

    String classifyTitle;
    String createTime;
    num id;
    
    factory HelpClassifications.fromJson(Map<String,dynamic> json) => _$HelpClassificationsFromJson(json);
    Map<String, dynamic> toJson() => _$HelpClassificationsToJson(this);
}
