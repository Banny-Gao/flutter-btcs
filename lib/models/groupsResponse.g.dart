// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groupsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupsResponse _$GroupsResponseFromJson(Map<String, dynamic> json) {
  return GroupsResponse()
    ..code = json['code'] as num
    ..message = json['message'] as String
    ..data = (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Group.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$GroupsResponseToJson(GroupsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data
    };
