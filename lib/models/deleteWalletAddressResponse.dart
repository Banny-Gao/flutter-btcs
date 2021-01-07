import 'package:json_annotation/json_annotation.dart';

part 'deleteWalletAddressResponse.g.dart';

@JsonSerializable()
class DeleteWalletAddressResponse {
    DeleteWalletAddressResponse();

    num code;
    String data;
    String message;
    
    factory DeleteWalletAddressResponse.fromJson(Map<String,dynamic> json) => _$DeleteWalletAddressResponseFromJson(json);
    Map<String, dynamic> toJson() => _$DeleteWalletAddressResponseToJson(this);
}
