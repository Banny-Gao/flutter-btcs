import 'package:json_annotation/json_annotation.dart';

part 'serverList.g.dart';

@JsonSerializable()
class ServerList {
    ServerList();

    String chargeWay;
    String costType;
    String number;
    String price;
    String serveProduct;
    String serviceName;
    String subtotal;
    
    factory ServerList.fromJson(Map<String,dynamic> json) => _$ServerListFromJson(json);
    Map<String, dynamic> toJson() => _$ServerListToJson(this);
}
