import 'package:dio/dio.dart';

import 'index.dart';

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

  return resp.data;
}

Future _passwordSignIn({phone, password}) async {
  final resp = await Request.dio.post(
    '/front/member/phoneLogin',
    data: {
      'phone': phone,
      'password': password,
    },
    options: Options(
      extra: {
        "showLoading": true,
      },
    ),
  );

  Request.netCache.cache.clear();

  return resp.data;
}

class API {
  static final signUp = _signUp;
  static final passwordSignIn = _passwordSignIn;
}
