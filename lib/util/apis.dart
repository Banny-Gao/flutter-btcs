import 'package:dio/dio.dart';

import 'index.dart';
import '../models/index.dart' as Models;

Future _signUp({phone, password, code, inviteCode}) async {
  final resp = await Request.dio.post(
    '/front/member/phoneRegister',
    data: {
      'phone': phone,
      'password': password,
      'code': code,
      'inviteCode': inviteCode,
    },
    options: Options(
      extra: {
        "showLoading": true,
      },
    ),
  );

  Request.netCache.cache.clear();

  print('signUp resp: ${resp}');

  return resp.data as Models.SignUpResponse;
}

class API {
  static final signUp = _signUp;
}
