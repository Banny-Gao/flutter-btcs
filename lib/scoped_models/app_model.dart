import 'dart:async';
import 'dart:core';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/index.dart';

class BaseModel extends Model {}

class AppModel extends Model
    with BaseModel, UserAuthModel, ThemeModel, ProfileModel
//, AppModel
{
  static Profile profile = Profile();

  AppModel() {
    init();
  }

  init() async {
    await initTheme();
    await initAuth();
    await initProfile();
  }
}

class ThemeModel extends BaseModel {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static const _THEME_KEY = "theme_prefs_key";
  static List<ThemeData> _themes = [ThemeData.light(), ThemeData.dark()];
  int _currentTheme = 0;

  ThemeData get theme => _themes[_currentTheme];

  Future<Null> toggleTheme() async {
    final SharedPreferences prefs = await _prefs;

    _currentTheme = (_currentTheme + 1) % _themes.length;
    prefs.setInt(_THEME_KEY, _currentTheme);
    notifyListeners();
  }

  Future<Null> initTheme() async {
    final SharedPreferences prefs = await _prefs;
    _currentTheme = prefs.getInt(_THEME_KEY) ?? 0;
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

class ProfileModel extends BaseModel {
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

    // 如果没有缓存策略，设置默认缓存策略
    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;
  }

  Future<Null> saveProfile() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("profile", jsonEncode(profile.toJson()));
  }
}
