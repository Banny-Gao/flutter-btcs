// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulletins.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bulletins _$BulletinsFromJson(Map<String, dynamic> json) {
  return Bulletins()
    ..content = json['content'] as String
    ..title = json['title'] as String
    ..id = json['id'] as num;
}

Map<String, dynamic> _$BulletinsToJson(Bulletins instance) => <String, dynamic>{
      'content': instance.content,
      'title': instance.title,
      'id': instance.id
    };
