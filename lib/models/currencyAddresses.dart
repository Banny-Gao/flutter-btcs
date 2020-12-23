import 'package:json_annotation/json_annotation.dart';
import "walletAddress.dart";
part 'currencyAddresses.g.dart';

@JsonSerializable()
class CurrencyAddresses {
    CurrencyAddresses();

    num code;
    String message;
    List<WalletAddress> data;
    
    factory CurrencyAddresses.fromJson(Map<String,dynamic> json) => _$CurrencyAddressesFromJson(json);
    Map<String, dynamic> toJson() => _$CurrencyAddressesToJson(this);
}
