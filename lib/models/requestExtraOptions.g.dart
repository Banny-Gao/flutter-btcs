// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requestExtraOptions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestExtraOptions _$RequestExtraOptionsFromJson(Map<String, dynamic> json) {
  return RequestExtraOptions()
    ..showLoading = json['showLoading'] as bool
    ..useResponseInterceptor = json['useResponseInterceptor'] as bool;
}

Map<String, dynamic> _$RequestExtraOptionsToJson(
        RequestExtraOptions instance) =>
    <String, dynamic>{
      'showLoading': instance.showLoading,
      'useResponseInterceptor': instance.useResponseInterceptor
    };
