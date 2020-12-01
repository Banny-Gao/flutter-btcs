import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../scopedModels/index.dart';
import '../models/index.dart';
import 'index.dart';

class RequestInterceptor extends Interceptor {
  bool _isLoading = false;

  @override
  Future onRequest(dynamic options) {
    final extra = RequestExtraOptions.fromJson(options.extra);
    if (extra.showLoading) {
      _isLoading = true;
      EasyLoading.show();
    }
    return super.onRequest(options);
  }

  @override
  Future onResponse(dynamic response) {
    final resp = ResponseBasic.fromJson(response.data);
    if (_isLoading) {
      EasyLoading.dismiss();
    }

    switch (resp.code) {
      case 401:
        // logout
        break;
      case 200:
        break;
      default:
        EasyLoading.showError(resp.message);
    }

    return super.onResponse(response);
  }

  @override
  Future onError(DioError error) {
    EasyLoading.showError(error.message);
    return super.onError(error);
  }
}

class Request {
  static NetCache netCache = NetCache();
  SharedPreferences _prefs;

  Request([this.context]) {
    _options = Options(extra: {"context": context});
  }

  BuildContext context;
  Options _options;
  static Dio dio = new Dio(BaseOptions(
    // baseUrl: 'http://5r29og8.hn3.mofasuidao.cn/api',
    baseUrl: 'http://47.93.123.178:9099/api',
  ))
    ..interceptors.add(RequestInterceptor());

  static void init() {
    // 添加缓存插件
    dio.interceptors.add(Request.netCache);
    // 设置用户token（可能为null，代表未登录）
    dio.options.headers['X-Token'] = ProfileModel.profile.token;
    dio.options.headers[HttpHeaders.contentTypeHeader] = 'application/json';
  }
}
