import 'package:json_annotation/json_annotation.dart';
import "bulletins.dart";
part 'bulletinsResponseData.g.dart';

@JsonSerializable()
class BulletinsResponseData {
    BulletinsResponseData();

    num endRow;
    bool hasNextPage;
    bool hasPreviousPage;
    bool isFirstPage;
    bool isLastPage;
    List<Bulletins> list;
    
    factory BulletinsResponseData.fromJson(Map<String,dynamic> json) => _$BulletinsResponseDataFromJson(json);
    Map<String, dynamic> toJson() => _$BulletinsResponseDataToJson(this);
}
