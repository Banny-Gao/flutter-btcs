import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../scopedModels/index.dart';
import '../models/index.dart';
import 'index.dart';

class RequestInterceptor extends LogInterceptor {
  RequestInterceptor() : super(requestBody: true, responseBody: true);

  bool _isLoading = false;

  void _printKV(String key, Object v) {
    logPrint('$key: $v');
  }

  void _printAll(msg) {
    msg.toString().split('\n').forEach(logPrint);
  }

  @override
  Future onRequest(dynamic options) {
    logPrint('*** Request ***');
    _printKV('uri', options.uri);

    if (requestHeader) {
      logPrint('headers:');
      options.headers.forEach((key, v) => _printKV(' $key', v));
    }
    if (requestBody) {
      logPrint('data:');
      _printAll(options.data);
    }

    final extra = RequestExtraOptions.fromJson(options.extra);
    if (extra.showLoading) {
      _isLoading = true;
      EasyLoading.show();
    }
    return super.onRequest(options);
  }

  @override
  Future onResponse(dynamic response) {
    _printKV('uri', response.request?.uri);
    if (responseHeader) {
      _printKV('statusCode', response.statusCode);
      if (response.isRedirect == true) {
        _printKV('redirect', response.realUri);
      }
    }
    if (responseBody) {
      logPrint('Response Text:');
      _printAll(response.toString());
    }

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
