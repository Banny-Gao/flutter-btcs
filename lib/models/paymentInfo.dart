import 'package:json_annotation/json_annotation.dart';

part 'paymentInfo.g.dart';

@JsonSerializable()
class PaymentInfo {
    PaymentInfo();

    num buyNumber;
    num countDownTime;
    String createTime;
    String currencyIconPath;
    String currencyName;
    String lcd;
    num money;
    String orderNumber;
    String payQr;
    String topAddress;
    String wxAccount;
    String wxQr;
    
    factory PaymentInfo.fromJson(Map<String,dynamic> json) => _$PaymentInfoFromJson(json);
    Map<String, dynamic> toJson() => _$PaymentInfoToJson(this);
}
