// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderEarningsResponseData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEarningsResponseData _$OrderEarningsResponseDataFromJson(
    Map<String, dynamic> json) {
  return OrderEarningsResponseData()
    ..endRow = json['endRow'] as num
    ..hasNextPage = json['hasNextPage'] as bool
    ..hasPreviousPage = json['hasPreviousPage'] as bool
    ..isFirstPage = json['isFirstPage'] as bool
    ..isLastPage = json['isLastPage'] as bool
    ..list = (json['list'] as List)
        ?.map((e) => e == null
            ? null
            : OrderEarnings.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$OrderEarningsResponseDataToJson(
        OrderEarningsResponseData instance) =>
    <String, dynamic>{
      'endRow': instance.endRow,
      'hasNextPage': instance.hasNextPage,
      'hasPreviousPage': instance.hasPreviousPage,
      'isFirstPage': instance.isFirstPage,
      'isLastPage': instance.isLastPage,
      'list': instance.list
    };
