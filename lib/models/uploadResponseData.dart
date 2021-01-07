import 'package:json_annotation/json_annotation.dart';

part 'uploadResponseData.g.dart';

@JsonSerializable()
class UploadResponseData {
    UploadResponseData();

    String url;
    
    factory UploadResponseData.fromJson(Map<String,dynamic> json) => _$UploadResponseDataFromJson(json);
    Map<String, dynamic> toJson() => _$UploadResponseDataToJson(this);
}
