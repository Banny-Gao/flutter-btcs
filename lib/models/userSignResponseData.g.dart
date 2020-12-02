// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userSignResponseData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSignResponseData _$UserSignResponseDataFromJson(Map<String, dynamic> json) {
  return UserSignResponseData()
    ..token = json['token'] as String
    ..phone = json['phone'] as String;
}

Map<String, dynamic> _$UserSignResponseDataToJson(
        UserSignResponseData instance) =>
    <String, dynamic>{'token': instance.token, 'phone': instance.phone};
