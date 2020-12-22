import 'package:json_annotation/json_annotation.dart';

part 'electricOrder.g.dart';

@JsonSerializable()
class ElectricOrder {
    ElectricOrder();

    String createTime;
    String currencyIconPath;
    String currencyName;
    String electricOrderNumber;
    num money;
    num orderStatus;
    String payAddress;
    String payQr;
    num currencyId;
    String orderNumber;
    
    factory ElectricOrder.fromJson(Map<String,dynamic> json) => _$ElectricOrderFromJson(json);
    Map<String, dynamic> toJson() => _$ElectricOrderToJson(this);
}
