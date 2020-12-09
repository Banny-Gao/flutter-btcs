import 'package:json_annotation/json_annotation.dart';

part 'dealResponseData.g.dart';

@JsonSerializable()
class DealResponseData {
    DealResponseData();

    String content;
    
    factory DealResponseData.fromJson(Map<String,dynamic> json) => _$DealResponseDataFromJson(json);
    Map<String, dynamic> toJson() => _$DealResponseDataToJson(this);
}
