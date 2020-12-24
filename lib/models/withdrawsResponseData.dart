import 'package:json_annotation/json_annotation.dart';
import "withdraw.dart";
part 'withdrawsResponseData.g.dart';

@JsonSerializable()
class WithdrawsResponseData {
    WithdrawsResponseData();

    num endRow;
    bool hasNextPage;
    bool hasPreviousPage;
    bool isFirstPage;
    bool isLastPage;
    List<Withdraw> list;
    
    factory WithdrawsResponseData.fromJson(Map<String,dynamic> json) => _$WithdrawsResponseDataFromJson(json);
    Map<String, dynamic> toJson() => _$WithdrawsResponseDataToJson(this);
}
