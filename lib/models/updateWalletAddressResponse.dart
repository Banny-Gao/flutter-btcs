import 'package:json_annotation/json_annotation.dart';

part 'updateWalletAddressResponse.g.dart';

@JsonSerializable()
class UpdateWalletAddressResponse {
    UpdateWalletAddressResponse();

    num code;
    String data;
    String message;
    
    factory UpdateWalletAddressResponse.fromJson(Map<String,dynamic> json) => _$UpdateWalletAddressResponseFromJson(json);
    Map<String, dynamic> toJson() => _$UpdateWalletAddressResponseToJson(this);
}
