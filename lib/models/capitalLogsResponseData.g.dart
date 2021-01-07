// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capitalLogsResponseData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CapitalLogsResponseData _$CapitalLogsResponseDataFromJson(
    Map<String, dynamic> json) {
  return CapitalLogsResponseData()
    ..endRow = json['endRow'] as num
    ..hasNextPage = json['hasNextPage'] as bool
    ..hasPreviousPage = json['hasPreviousPage'] as bool
    ..isFirstPage = json['isFirstPage'] as bool
    ..isLastPage = json['isLastPage'] as bool
    ..list = (json['list'] as List)
        ?.map((e) =>
            e == null ? null : CapitalLog.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CapitalLogsResponseDataToJson(
        CapitalLogsResponseData instance) =>
    <String, dynamic>{
      'endRow': instance.endRow,
      'hasNextPage': instance.hasNextPage,
      'hasPreviousPage': instance.hasPreviousPage,
      'isFirstPage': instance.isFirstPage,
      'isLastPage': instance.isLastPage,
      'list': instance.list
    };
