// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helpClassifications.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HelpClassifications _$HelpClassificationsFromJson(Map<String, dynamic> json) {
  return HelpClassifications()
    ..classifyTitle = json['classifyTitle'] as String
    ..id = json['id'] as num;
}

Map<String, dynamic> _$HelpClassificationsToJson(
        HelpClassifications instance) =>
    <String, dynamic>{
      'classifyTitle': instance.classifyTitle,
      'id': instance.id
    };
