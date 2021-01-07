import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable()
class Pagination {
    Pagination();

    num pageSize;
    num pageNum;
    bool isCompleted;
    bool isLoading;
    
    factory Pagination.fromJson(Map<String,dynamic> json) => _$PaginationFromJson(json);
    Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
