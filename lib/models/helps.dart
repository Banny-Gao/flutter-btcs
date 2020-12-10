import 'package:json_annotation/json_annotation.dart';

part 'helps.g.dart';

@JsonSerializable()
class Helps {
    Helps();

    String content;
    String helpClassifyTitle;
    num id;
    String title;
    
    factory Helps.fromJson(Map<String,dynamic> json) => _$HelpsFromJson(json);
    Map<String, dynamic> toJson() => _$HelpsToJson(this);
}
