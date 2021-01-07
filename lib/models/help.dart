import 'package:json_annotation/json_annotation.dart';

part 'help.g.dart';

@JsonSerializable()
class Help {
    Help();

    String content;
    String helpClassifyTitle;
    num id;
    String title;
    
    factory Help.fromJson(Map<String,dynamic> json) => _$HelpFromJson(json);
    Map<String, dynamic> toJson() => _$HelpToJson(this);
}
