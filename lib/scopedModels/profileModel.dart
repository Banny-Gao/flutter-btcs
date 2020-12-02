import 'dart:async';
import 'dart:core';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'index.dart';
import '../models/index.dart';

class ProfileModel extends BaseModel {
  bool _isLogin = false;
  String _token;
  bool get isLogin => _isLogin;
  String get token => _token;

  static Profile profile = Profile();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<Null> initProfile() async {
    final SharedPreferences prefs = await _prefs;
    var _profile = prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }

    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;
    profile.token = '';
    _token = profile.token;
    if (_token != null && _token != "") {
      _isLogin = true;
    }

    print('----- ProfileModel initialized');
    print('profile: ${profile.toJson()}');
  }

  Future<Null> saveProfile() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("profile", jsonEncode(profile.toJson()));

    notifyListeners();
  }

  Future<Null> toggleLogStatus(bool isLogin, {token, phone}) async {
    _isLogin = isLogin;
    profile
      ..token = token ?? ''
      ..phone = phone ?? '';
    saveProfile();
  }
}
