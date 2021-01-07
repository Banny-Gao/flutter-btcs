import 'package:json_annotation/json_annotation.dart';
import "help.dart";
part 'helpsData.g.dart';

@JsonSerializable()
class HelpsData {
    HelpsData();

    num endRow;
    bool hasNextPage;
    bool hasPreviousPage;
    bool isFirstPage;
    bool isLastPage;
    List<Help> list;
    
    factory HelpsData.fromJson(Map<String,dynamic> json) => _$HelpsDataFromJson(json);
    Map<String, dynamic> toJson() => _$HelpsDataToJson(this);
}
