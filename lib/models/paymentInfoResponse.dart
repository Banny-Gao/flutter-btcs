import 'package:json_annotation/json_annotation.dart';
import "paymentInfo.dart";
part 'paymentInfoResponse.g.dart';

@JsonSerializable()
class PaymentInfoResponse {
    PaymentInfoResponse();

    num code;
    String message;
    PaymentInfo data;
    
    factory PaymentInfoResponse.fromJson(Map<String,dynamic> json) => _$PaymentInfoResponseFromJson(json);
    Map<String, dynamic> toJson() => _$PaymentInfoResponseToJson(this);
}
