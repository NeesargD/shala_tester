import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static saveData(String key, String data) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString(key, data);
  }

  static saveIntData(String key, int data) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setInt(key, data);
  }

  static saveList(String key, List<String> data) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setStringList(key, data);
  }

  static Future<List<String>?> getList(String key) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(key);
  }

  static Future<String?> getData(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  static Future<int?> getIntData(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getInt(key);
  }

  static Future<bool> clearData() async {
    final pref = await SharedPreferences.getInstance();
    return pref.clear();
  }

  static Future<bool> removeData(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.remove(key);
  }
}
