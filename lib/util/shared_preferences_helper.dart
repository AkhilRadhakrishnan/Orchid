import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/doctor.dart';
import '../models/authentication.dart';
import '../models/services.dart';

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

  static Future<void> saveDoctorDetails(Doctor value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("doctor", jsonEncode(value).toString());
  }

  static Future<Doctor?> getDoctorDetails() async {
    final SharedPreferences prefs = await _prefs;
    dynamic doc = prefs.getString("doctor");
    if (doc == 'null' || doc == null) {
      return null;
    }
    return Doctor.fromJson(jsonDecode(doc!));
  }

  static Future<void> clearDoctorDetails() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove("doctor");
  }

  static Future<void> saveServiceDetails(Services value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("service", jsonEncode(value).toString());
  }

  static Future<Services?> getServiceDetails() async {
    final SharedPreferences prefs = await _prefs;
    dynamic ser = prefs.getString("service");
    if (ser == 'null' || ser == null) {
      return null;
    }
    return Services.fromJson(jsonDecode(ser!));
  }

  static Future<void> clearServiceDetails() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove("service");
  }
  static Future<void> clearAll() async {
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
  }
}
