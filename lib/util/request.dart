import 'dart:io';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../scopedModels/index.dart';
import '../models/index.dart';
import '../routes.dart';
import 'index.dart';

final getBaseRequest = () => Dio(BaseOptions(
      baseUrl: BaseUrl,
      connectTimeout: 10000,
      receiveTimeout: 10000,
    ));

class RequestInterceptor extends LogInterceptor {
  RequestInterceptor() : super(requestBody: true, responseBody: true);

  Map<String, dynamic> extraOptions = {};

  @override
  Future onRequest(dynamic options) {
    // 设置用户token（可能为null，代表未登录）
    options.headers['X-Token'] = ProfileModel.profile.token;
    final extra = RequestExtraOptions.fromJson(options.extra);
    final bool loading = extra.showLoading != null ? extra.showLoading : false;
    final bool useResponseInterceptor = extra.useResponseInterceptor != null
        ? extra.useResponseInterceptor
        : true;

    extraOptions['${options.uri}'] = {
      'loading': loading,
      'useResponseInterceptor': useResponseInterceptor,
    };

    if (loading) EasyLoading.show();

    return super.onRequest(options);
  }

  @override
  Future onResponse(dynamic response) {
    final bool loading = extraOptions['${response.request.uri}']['loading'];
    final bool useResponseInterceptor =
        extraOptions['${response.request.uri}']['useResponseInterceptor'];

    if (loading) EasyLoading.dismiss();

    if (useResponseInterceptor) {
      final resp = ResponseBasic.fromJson(response.data);
      final context = GlobalRoute.navigatorKey.currentContext;

      switch (resp.code) {
        case 401:
          // logout
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/login',
            (Route route) => false,
          );
          break;
        case 200:
          break;
        default:
          EasyLoading.showError(resp.message);
      }
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

  static Dio dio = getBaseRequest();

  static Future<void> init() {
    // 添加缓存插件
    dio.interceptors.add(Request.netCache);
    dio.interceptors.add(RequestInterceptor());
    dio.options.headers[HttpHeaders.contentTypeHeader] = 'application/json';

    // https 证书校验
    // String PEM = "XXXXX"; // certificate content
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (client) {
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) {
    //     if (cert.pem == PEM) {
    //       // Verify the certificate
    //       return true;
    //     }
    //     return false;
    //   };
    // };
  }
}
