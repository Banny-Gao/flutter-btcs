import 'package:json_annotation/json_annotation.dart';

part 'bulletins.g.dart';

@JsonSerializable()
class Bulletins {
    Bulletins();

    String content;
    String title;
    num id;
    
    factory Bulletins.fromJson(Map<String,dynamic> json) => _$BulletinsFromJson(json);
    Map<String, dynamic> toJson() => _$BulletinsToJson(this);
}
