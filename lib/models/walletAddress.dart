import 'package:json_annotation/json_annotation.dart';

part 'walletAddress.g.dart';

@JsonSerializable()
class WalletAddress {
    WalletAddress();

    String address;
    num currencyId;
    String currencyName;
    num id;
    num memberId;
    
    factory WalletAddress.fromJson(Map<String,dynamic> json) => _$WalletAddressFromJson(json);
    Map<String, dynamic> toJson() => _$WalletAddressToJson(this);
}
