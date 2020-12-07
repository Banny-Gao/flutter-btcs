import 'package:dio/dio.dart';

import 'index.dart';

// 类型 1:更换手机绑定 2.更新 3.注册,4.手机号登陆，5.密码修改
Future _getCode(phone, type) async {
  final resp = await Request.dio.get(
    '/front/member/sendNote',
    queryParameters: {
      'phone': phone,
      'type': type,
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

// 注册
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

// 密码登录
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

// 首页轮播图
Future _getSlides({pageNum = 1, pageSize = 3}) async {
  final resp = await Request.dio.get(
    '/front/slideshow/list',
    queryParameters: {
      'pageNum': pageNum,
      'pageSize': pageSize,
    },
  );

  return resp.data;
}

// 首页公告列表
Future _getBulletins({pageNum = 1, pageSize = 3}) async {
  final resp = await Request.dio.get(
    '/front/bulletin/list',
    queryParameters: {
      'pageNum': pageNum,
      'pageSize': pageSize,
    },
  );

  return resp.data;
}

class API {
  static final signUp = _signUp;
  static final passwordSignIn = _passwordSignIn;
  static final getSlides = _getSlides;
  static final getBulletins = _getBulletins;
  static final getCode = _getCode;
}
