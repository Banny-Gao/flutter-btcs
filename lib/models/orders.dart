import 'package:json_annotation/json_annotation.dart';

part 'orders.g.dart';

@JsonSerializable()
class Orders {
    Orders();

    num awaitElectricity;
    num buyNumber;
    num causeStatus;
    String createTime;
    String currencyIconPath;
    String currencyName;
    num energyStatus;
    String groupName;
    num id;
    String lcd;
    num memberId;
    String miningEndTime;
    num money;
    String orderNumber;
    num paymentNumber;
    String producImg;
    num robotStatus;
    num status;
    num surplusMoney;
    num totalEarnings;
    
    factory Orders.fromJson(Map<String,dynamic> json) => _$OrdersFromJson(json);
    Map<String, dynamic> toJson() => _$OrdersToJson(this);
}
