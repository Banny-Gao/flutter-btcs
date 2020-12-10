// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'help.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Help _$HelpFromJson(Map<String, dynamic> json) {
  return Help()
    ..content = json['content'] as String
    ..helpClassifyTitle = json['helpClassifyTitle'] as String
    ..id = json['id'] as num
    ..title = json['title'] as String;
}

Map<String, dynamic> _$HelpToJson(Help instance) => <String, dynamic>{
      'content': instance.content,
      'helpClassifyTitle': instance.helpClassifyTitle,
      'id': instance.id,
      'title': instance.title
    };
