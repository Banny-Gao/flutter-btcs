import 'package:json_annotation/json_annotation.dart';
import "data.dart";
part 'responseBasic.g.dart';

@JsonSerializable()
class ResponseBasic {
    ResponseBasic();

    num code;
    Data data;
    String message;
    
    factory ResponseBasic.fromJson(Map<String,dynamic> json) => _$ResponseBasicFromJson(json);
    Map<String, dynamic> toJson() => _$ResponseBasicToJson(this);
}
