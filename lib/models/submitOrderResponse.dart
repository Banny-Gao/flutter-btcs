import 'package:json_annotation/json_annotation.dart';
import "paymentInfo.dart";
part 'submitOrderResponse.g.dart';

@JsonSerializable()
class SubmitOrderResponse {
    SubmitOrderResponse();

    num code;
    String message;
    PaymentInfo data;
    
    factory SubmitOrderResponse.fromJson(Map<String,dynamic> json) => _$SubmitOrderResponseFromJson(json);
    Map<String, dynamic> toJson() => _$SubmitOrderResponseToJson(this);
}
