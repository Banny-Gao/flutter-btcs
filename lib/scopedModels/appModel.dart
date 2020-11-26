import 'dart:core';

import 'package:scoped_model/scoped_model.dart';

import 'index.dart';

class BaseModel extends Model {}

class AppModel extends Model
    with BaseModel, UserAuthModel, ThemeModel, ProfileModel
//, AppModel
{
  AppModel() {
    init();
  }

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  init() async {
    await initTheme();
    await initAuth();
    await initProfile();

    //初始化网络请求相关配置
    // Git.init();
  }
}
