import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../themes/galleryThemeData.dart';

import 'index.dart';

class ThemeModel extends BaseModel {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static const _THEME_KEY = "theme_prefs_key";
  static List<ThemeData> _themes = [
    GalleryThemeData.lightThemeData,
    GalleryThemeData.darkThemeData
  ];
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

    print('--------- ThemeModel initialized');
  }
}
