import 'package:json_annotation/json_annotation.dart';
import "slidesResponseData.dart";
part 'slidesResponse.g.dart';

@JsonSerializable()
class SlidesResponse {
    SlidesResponse();

    num code;
    SlidesResponseData data;
    String message;
    
    factory SlidesResponse.fromJson(Map<String,dynamic> json) => _$SlidesResponseFromJson(json);
    Map<String, dynamic> toJson() => _$SlidesResponseToJson(this);
}
