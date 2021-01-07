import 'package:json_annotation/json_annotation.dart';
import "helpsData.dart";
part 'helpsResponse.g.dart';

@JsonSerializable()
class HelpsResponse {
    HelpsResponse();

    num code;
    String message;
    HelpsData data;
    
    factory HelpsResponse.fromJson(Map<String,dynamic> json) => _$HelpsResponseFromJson(json);
    Map<String, dynamic> toJson() => _$HelpsResponseToJson(this);
}
