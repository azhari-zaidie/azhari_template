// lib/core/secret/get_pref.dart
// Utility class for SharedPreferences management

import 'package:shared_preferences/shared_preferences.dart';

class GetPref {
  // Private constructor to prevent instantiation
  GetPref._();

  // Helper method to get SharedPreferences instance
  static Future<SharedPreferences> get instance async {
    return await SharedPreferences.getInstance();
  }

  // Helper methods for common preferences operations
  static Future<bool> setBool(String key, bool value) async {
    final prefs = await instance;
    return await prefs.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    final prefs = await instance;
    return prefs.getBool(key);
  }

  static Future<bool> setString(String key, String value) async {
    final prefs = await instance;
    return await prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final prefs = await instance;
    return prefs.getString(key);
  }

  static Future<bool> setInt(String key, int value) async {
    final prefs = await instance;
    return await prefs.setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    final prefs = await instance;
    return prefs.getInt(key);
  }

  static Future<bool> remove(String key) async {
    final prefs = await instance;
    return await prefs.remove(key);
  }

  static Future<bool> clear() async {
    final prefs = await instance;
    return await prefs.clear();
  }
}

