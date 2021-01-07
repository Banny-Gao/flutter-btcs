// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination _$PaginationFromJson(Map<String, dynamic> json) {
  return Pagination()
    ..pageSize = json['pageSize'] as num
    ..pageNum = json['pageNum'] as num
    ..isCompleted = json['isCompleted'] as bool
    ..isLoading = json['isLoading'] as bool;
}

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'pageSize': instance.pageSize,
      'pageNum': instance.pageNum,
      'isCompleted': instance.isCompleted,
      'isLoading': instance.isLoading
    };
