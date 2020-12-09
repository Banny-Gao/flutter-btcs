import 'package:json_annotation/json_annotation.dart';
import "helpClassifications.dart";
part 'helpClassificationsResponseData.g.dart';

@JsonSerializable()
class HelpClassificationsResponseData {
    HelpClassificationsResponseData();

    num endRow;
    bool hasNextPage;
    bool hasPreviousPage;
    bool isFirstPage;
    bool isLastPage;
    List<HelpClassifications> list;
    
    factory HelpClassificationsResponseData.fromJson(Map<String,dynamic> json) => _$HelpClassificationsResponseDataFromJson(json);
    Map<String, dynamic> toJson() => _$HelpClassificationsResponseDataToJson(this);
}
