import 'package:json_annotation/json_annotation.dart';

part 'slides.g.dart';

@JsonSerializable()
class Slides {
    Slides();

    String address;
    num id;
    String imageUrl;
    
    factory Slides.fromJson(Map<String,dynamic> json) => _$SlidesFromJson(json);
    Map<String, dynamic> toJson() => _$SlidesToJson(this);
}
