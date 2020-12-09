import 'package:json_annotation/json_annotation.dart';
import "uploadResponseData.dart";
part 'uploadResponse.g.dart';

@JsonSerializable()
class UploadResponse {
    UploadResponse();

    num code;
    UploadResponseData data;
    String message;
    
    factory UploadResponse.fromJson(Map<String,dynamic> json) => _$UploadResponseFromJson(json);
    Map<String, dynamic> toJson() => _$UploadResponseToJson(this);
}
