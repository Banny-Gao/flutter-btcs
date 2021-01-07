import 'dart:core';

import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'index.dart';
import '../util/index.dart' as Utils;
import '../models/index.dart' as Models;

class BaseModel extends Model {}

class AppModel extends Model with BaseModel, ThemeModel, ProfileModel
//, AppModel
{
  AppModel() {}
  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");
  static List coinList;
  static bool isSocketConnected = false;

  List<Models.Coin> coins = [];

  Future<Null> init() async {
    await initTheme();
    await initProfile();

    await Utils.Request.init();

    print('-------- AppModel initialized');
  }

  Future<Null> getCoins() async {
    final dio = Utils.getBaseRequest();

    final response = await dio.get('/front/currency/list');

    final resp = Models.CoinsResponse.fromJson(response.data);

    if (resp.code != 200) {
      EasyLoading.showError(resp.message);
      return;
    }

    coins = resp.data;
    coinList = resp.data;
  }
}
