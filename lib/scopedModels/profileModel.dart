import 'dart:async';
import 'dart:core';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'index.dart';
import '../models/index.dart';

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
