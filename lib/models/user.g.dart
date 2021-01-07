// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..autoStatus = json['autoStatus'] as num
    ..inviteCode = json['inviteCode'] as String
    ..memberAvatar = json['memberAvatar'] as String
    ..memberName = json['memberName'] as String
    ..memberPhone = json['memberPhone'] as String
    ..memberSex = json['memberSex'] as String
    ..passwdState = json['passwdState'] as num
    ..payPwdState = json['payPwdState'] as num;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'autoStatus': instance.autoStatus,
      'inviteCode': instance.inviteCode,
      'memberAvatar': instance.memberAvatar,
      'memberName': instance.memberName,
      'memberPhone': instance.memberPhone,
      'memberSex': instance.memberSex,
      'passwdState': instance.passwdState,
      'payPwdState': instance.payPwdState
    };
