import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_otp.dart';

class SharedPreferencesHelper {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();
  static Future<void> saveAccessToken(value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("access_token", value);
  }

  static Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString("access_token");
  }

  static Future<void> saveUserDetails(User? value) async {
    final SharedPreferences prefs = await _prefs;
    var j = jsonEncode(value).toString();
    prefs.setString("user", jsonEncode(value).toString());
  }

  static Future<User> getUserDetails() async {
    final SharedPreferences prefs = await _prefs;
    dynamic user = prefs.getString("user");
    if (user == 'null' || user == null) {
      return User();
    }
    return User.fromJson(jsonDecode(user!));
  }
}
