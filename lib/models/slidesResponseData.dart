import 'package:json_annotation/json_annotation.dart';
import "slides.dart";
part 'slidesResponseData.g.dart';

@JsonSerializable()
class SlidesResponseData {
    SlidesResponseData();

    num endRow;
    bool hasNextPage;
    bool hasPreviousPage;
    bool isFirstPage;
    bool isLastPage;
    List<Slides> list;
    
    factory SlidesResponseData.fromJson(Map<String,dynamic> json) => _$SlidesResponseDataFromJson(json);
    Map<String, dynamic> toJson() => _$SlidesResponseDataToJson(this);
}
