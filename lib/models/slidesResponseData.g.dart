// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slidesResponseData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlidesResponseData _$SlidesResponseDataFromJson(Map<String, dynamic> json) {
  return SlidesResponseData()
    ..endRow = json['endRow'] as num
    ..hasNextPage = json['hasNextPage'] as bool
    ..hasPreviousPage = json['hasPreviousPage'] as bool
    ..isFirstPage = json['isFirstPage'] as bool
    ..isLastPage = json['isLastPage'] as bool
    ..list = (json['list'] as List)
        ?.map((e) =>
            e == null ? null : Slides.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SlidesResponseDataToJson(SlidesResponseData instance) =>
    <String, dynamic>{
      'endRow': instance.endRow,
      'hasNextPage': instance.hasNextPage,
      'hasPreviousPage': instance.hasPreviousPage,
      'isFirstPage': instance.isFirstPage,
      'isLastPage': instance.isLastPage,
      'list': instance.list
    };
