import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models.dart';
import 'dart:async';
import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';

class BaseModel extends Model {}

class AppModel extends Model with BaseModel, UserAuthModel, UserModel
//, AppModel
{
  final SharedPreferences _sharedPrefs;
  static const _THEME_KEY = "theme_prefs_key";

  AppModel(this._sharedPrefs) {
    _currentTheme = _sharedPrefs.getInt(_THEME_KEY) ?? 0;
    initAuth();
  }

  static List<ThemeData> _themes = [ThemeData.light(), ThemeData.dark()];
  int _currentTheme = 0;

  ThemeData get theme => _themes[_currentTheme];

  void toggleTheme() {
    _currentTheme = (_currentTheme + 1) % _themes.length;
    _sharedPrefs.setInt(_THEME_KEY, _currentTheme);
    notifyListeners();
  }
}

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

  initAuth() {
    _prefs
        .then((p) => p.getString("token"))
        .then((__token) {
          _token = __token;
          if (_token != null && _token != "") {
            _isLogin = true;
          }
        })
        .catchError((e) {})
        .whenComplete(this.notifyListeners);
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
