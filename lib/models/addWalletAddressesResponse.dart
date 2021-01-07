import 'package:json_annotation/json_annotation.dart';

part 'addWalletAddressesResponse.g.dart';

@JsonSerializable()
class AddWalletAddressesResponse {
    AddWalletAddressesResponse();

    num code;
    String data;
    String message;
    
    factory AddWalletAddressesResponse.fromJson(Map<String,dynamic> json) => _$AddWalletAddressesResponseFromJson(json);
    Map<String, dynamic> toJson() => _$AddWalletAddressesResponseToJson(this);
}
