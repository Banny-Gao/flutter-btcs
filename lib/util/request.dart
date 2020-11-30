import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
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
    baseUrl: 'http://47.93.123.178:9099/',
  ));

  static void init() {
    // 添加缓存插件
    dio.interceptors.add(Request.netCache);
    // 设置用户token（可能为null，代表未登录）
    dio.options.headers['X-Token'] = ProfileModel.profile.token;

    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    if (!AppModel.isRelease) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY localhost:8888";
        };
        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }
}
