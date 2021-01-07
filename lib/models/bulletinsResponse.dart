import 'package:json_annotation/json_annotation.dart';
import "bulletinsResponseData.dart";
part 'bulletinsResponse.g.dart';

@JsonSerializable()
class BulletinsResponse {
    BulletinsResponse();

    num code;
    BulletinsResponseData data;
    String message;
    
    factory BulletinsResponse.fromJson(Map<String,dynamic> json) => _$BulletinsResponseFromJson(json);
    Map<String, dynamic> toJson() => _$BulletinsResponseToJson(this);
}
