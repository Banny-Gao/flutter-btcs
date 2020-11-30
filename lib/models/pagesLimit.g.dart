// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagesLimit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagesLimit _$PagesLimitFromJson(Map<String, dynamic> json) {
  return PagesLimit()
    ..pageNum = json['pageNum'] as num
    ..pageSize = json['pageSize'] as num;
}

Map<String, dynamic> _$PagesLimitToJson(PagesLimit instance) =>
    <String, dynamic>{
      'pageNum': instance.pageNum,
      'pageSize': instance.pageSize
    };
