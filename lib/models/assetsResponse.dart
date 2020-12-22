import 'package:json_annotation/json_annotation.dart';
import "asset.dart";
part 'assetsResponse.g.dart';

@JsonSerializable()
class AssetsResponse {
    AssetsResponse();

    num code;
    String message;
    List<Asset> data;
    
    factory AssetsResponse.fromJson(Map<String,dynamic> json) => _$AssetsResponseFromJson(json);
    Map<String, dynamic> toJson() => _$AssetsResponseToJson(this);
}
