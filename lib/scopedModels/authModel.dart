import 'dart:async';
import 'dart:core';

import 'package:shared_preferences/shared_preferences.dart';

import 'index.dart';

class UserAuthModel extends BaseModel {
  bool _isLogin = false;
  String _token;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool get isLogin => _isLogin;
  String get token => _token;

  Future<Null> _saveToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("token", token);
  }

  Future<Null> initAuth() async {
    final SharedPreferences prefs = await _prefs;
    try {
      _token = prefs.getString("token");
      if (_token != null && _token != "") {
        _isLogin = true;
      }
    } finally {
      this.notifyListeners();
    }
  }

  Future<Null> logout() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove("token");
    _isLogin = false;
    _token = null;
    notifyListeners();
  }

  Future<Null> login(String token) async {
    _saveToken(token);
    _token = token;
    _isLogin = true;
    notifyListeners();
  }
}
