// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requsets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Requsets _$RequsetsFromJson(Map<String, dynamic> json) {
  return Requsets()
    ..signUp = json['signUp'] as Map<String, dynamic>
    ..bulletins = json['bulletins'] == null
        ? null
        : PagesLimit.fromJson(json['bulletins'] as Map<String, dynamic>);
}

Map<String, dynamic> _$RequsetsToJson(Requsets instance) => <String, dynamic>{
      'signUp': instance.signUp,
      'bulletins': instance.bulletins
    };
