// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slides.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Slides _$SlidesFromJson(Map<String, dynamic> json) {
  return Slides()
    ..address = json['address'] as String
    ..id = json['id'] as num
    ..imageUrl = json['imageUrl'] as String;
}

Map<String, dynamic> _$SlidesToJson(Slides instance) => <String, dynamic>{
      'address': instance.address,
      'id': instance.id,
      'imageUrl': instance.imageUrl
    };
