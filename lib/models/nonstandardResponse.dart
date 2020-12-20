import 'package:json_annotation/json_annotation.dart';

part 'nonstandardResponse.g.dart';

@JsonSerializable()
class NonstandardResponse {
    NonstandardResponse();

    num code;
    String message;
    String data;
    
    factory NonstandardResponse.fromJson(Map<String,dynamic> json) => _$NonstandardResponseFromJson(json);
    Map<String, dynamic> toJson() => _$NonstandardResponseToJson(this);
}
