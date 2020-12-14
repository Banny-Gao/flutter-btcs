import 'package:json_annotation/json_annotation.dart';

part 'deleteWalletAddress.g.dart';

@JsonSerializable()
class DeleteWalletAddress {
    DeleteWalletAddress();

    num code;
    String data;
    String message;
    
    factory DeleteWalletAddress.fromJson(Map<String,dynamic> json) => _$DeleteWalletAddressFromJson(json);
    Map<String, dynamic> toJson() => _$DeleteWalletAddressToJson(this);
}
