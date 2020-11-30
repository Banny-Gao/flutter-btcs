import 'package:json_annotation/json_annotation.dart';
import "pagesLimit.dart";
part 'requsets.g.dart';

@JsonSerializable()
class Requsets {
    Requsets();

    Map<String,dynamic> signUp;
    PagesLimit bulletins;
    
    factory Requsets.fromJson(Map<String,dynamic> json) => _$RequsetsFromJson(json);
    Map<String, dynamic> toJson() => _$RequsetsToJson(this);
}
