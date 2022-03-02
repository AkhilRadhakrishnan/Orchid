import 'package:shared_preferences/shared_preferences.dart';

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
}
