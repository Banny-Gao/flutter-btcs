// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helps.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Helps _$HelpsFromJson(Map<String, dynamic> json) {
  return Helps()
    ..content = json['content'] as String
    ..helpClassifyTitle = json['helpClassifyTitle'] as String
    ..id = json['id'] as num
    ..title = json['title'] as String;
}

Map<String, dynamic> _$HelpsToJson(Helps instance) => <String, dynamic>{
      'content': instance.content,
      'helpClassifyTitle': instance.helpClassifyTitle,
      'id': instance.id,
      'title': instance.title
    };
