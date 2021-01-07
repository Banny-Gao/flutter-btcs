import 'package:json_annotation/json_annotation.dart';
import "walletAddressesResponseData.dart";
part 'walletAddressesResponse.g.dart';

@JsonSerializable()
class WalletAddressesResponse {
    WalletAddressesResponse();

    num code;
    WalletAddressesResponseData data;
    String message;
    
    factory WalletAddressesResponse.fromJson(Map<String,dynamic> json) => _$WalletAddressesResponseFromJson(json);
    Map<String, dynamic> toJson() => _$WalletAddressesResponseToJson(this);
}
