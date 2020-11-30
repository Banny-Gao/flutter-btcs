import 'package:json_annotation/json_annotation.dart';

part 'pagesLimit.g.dart';

@JsonSerializable()
class PagesLimit {
    PagesLimit();

    num pageNum;
    num pageSize;
    
    factory PagesLimit.fromJson(Map<String,dynamic> json) => _$PagesLimitFromJson(json);
    Map<String, dynamic> toJson() => _$PagesLimitToJson(this);
}
