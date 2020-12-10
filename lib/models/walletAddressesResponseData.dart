import 'package:json_annotation/json_annotation.dart';
import "walletAddress.dart";
part 'walletAddressesResponseData.g.dart';

@JsonSerializable()
class WalletAddressesResponseData {
    WalletAddressesResponseData();

    num endRow;
    bool hasNextPage;
    bool hasPreviousPage;
    bool isFirstPage;
    bool isLastPage;
    List<WalletAddress> list;
    
    factory WalletAddressesResponseData.fromJson(Map<String,dynamic> json) => _$WalletAddressesResponseDataFromJson(json);
    Map<String, dynamic> toJson() => _$WalletAddressesResponseDataToJson(this);
}
