import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'scopedModels/index.dart';
import 'app.dart';

void collectLog(String line) {
  //收集日志
}
void reportErrorAndLog(FlutterErrorDetails details) {
  //上报错误和日志逻辑
}

FlutterErrorDetails makeDetails(Object obj, StackTrace stack) {
  // 构建错误信息
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppModel model = AppModel();
  await model.init();

  FlutterError.onError = (FlutterErrorDetails details) {
    reportErrorAndLog(details);
  };

  runZoned(
    () => runApp(ScopedModel<AppModel>(model: model, child: OreApp())),
    zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        collectLog(line); // 收集日志
      },
    ),
    onError: (Object obj, StackTrace stack) {
      var details = makeDetails(obj, stack);
      reportErrorAndLog(details);
    },
  );
}
