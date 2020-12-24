import 'package:json_annotation/json_annotation.dart';
import "withdrawsResponseData.dart";
part 'withdrawsResponse.g.dart';

@JsonSerializable()
class WithdrawsResponse {
    WithdrawsResponse();

    num code;
    WithdrawsResponseData data;
    String message;
    
    factory WithdrawsResponse.fromJson(Map<String,dynamic> json) => _$WithdrawsResponseFromJson(json);
    Map<String, dynamic> toJson() => _$WithdrawsResponseToJson(this);
}
