import 'package:json_annotation/json_annotation.dart';
import "electricOrder.dart";
part 'electricOrderResponse.g.dart';

@JsonSerializable()
class ElectricOrderResponse {
    ElectricOrderResponse();

    num code;
    String message;
    ElectricOrder data;
    
    factory ElectricOrderResponse.fromJson(Map<String,dynamic> json) => _$ElectricOrderResponseFromJson(json);
    Map<String, dynamic> toJson() => _$ElectricOrderResponseToJson(this);
}
