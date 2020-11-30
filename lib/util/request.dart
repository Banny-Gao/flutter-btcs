import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../scopedModels/index.dart';
import 'index.dart';

class Request {
  static NetCache netCache = NetCache();
  SharedPreferences _prefs;

  Request([this.context]) {
    _options = Options(extra: {"context": context});
  }

  BuildContext context;
  Options _options;
  static Dio dio = new Dio(BaseOptions(
    baseUrl: 'http://5r29og8.hn3.mofasuidao.cn/api',
  ));
  // ..interceptors.add(LogInterceptor(requestBody: true));

  static void init() {
    // 添加缓存插件
    dio.interceptors.add(Request.netCache);
    // 设置用户token（可能为null，代表未登录）
    dio.options.headers['X-Token'] = ProfileModel.profile.token;
    dio.options.headers[HttpHeaders.contentTypeHeader] = 'application/json';
  }
}
