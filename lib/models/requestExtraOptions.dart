import 'package:json_annotation/json_annotation.dart';

part 'requestExtraOptions.g.dart';

@JsonSerializable()
class RequestExtraOptions {
    RequestExtraOptions();

    bool showLoading;
    
    factory RequestExtraOptions.fromJson(Map<String,dynamic> json) => _$RequestExtraOptionsFromJson(json);
    Map<String, dynamic> toJson() => _$RequestExtraOptionsToJson(this);
}
