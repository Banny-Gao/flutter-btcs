// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signUpResponseData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpResponseData _$SignUpResponseDataFromJson(Map<String, dynamic> json) {
  return SignUpResponseData()
    ..token = json['token'] as String
    ..phone = json['phone'] as String;
}

Map<String, dynamic> _$SignUpResponseDataToJson(SignUpResponseData instance) =>
    <String, dynamic>{'token': instance.token, 'phone': instance.phone};
