import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class CacheServices {
  static SharedPreferences? sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData(String key) {
    return sharedPreferences?.get(key);
  }

  static Future<bool> saveCachedData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences!.setString(key, value);
    }
    if (value is int) {
      return await sharedPreferences!.setInt(key, value);
    }
    if (value is bool) {
      return await sharedPreferences!.setBool(key, value);
    }
    if (value is double) {
      return await sharedPreferences!.setDouble(key, value);
    }
    if (value is List<String>) {
      return await sharedPreferences!.setStringList(key, value);
    }
    if (value is List<int>) {
      List<String> stringList = value.map((item) => item.toString()).toList();
      return await sharedPreferences!.setStringList(key, stringList);
    }
    if (value is List) {
      List<String> jsonList = value.map((item) => jsonEncode(item)).toList();
      return await sharedPreferences!.setStringList(key, jsonList);
    }
    return false;
  }

  static Future<List<int>> getIntList(String key) async {
    final stringList = sharedPreferences?.getStringList(key);
    if (stringList == null) return [];
    return stringList.map((item) => int.parse(item)).toList();
  }

  static Future<List<T>> getList<T>({
    required String key,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final jsonStringList = sharedPreferences?.getStringList(key);
    if (jsonStringList == null) return [];

    return jsonStringList
        .map((jsonString) => fromJson(jsonDecode(jsonString)))
        .toList();
  }

  static Future<bool> removeCacheData({required String key}) async {
    return await sharedPreferences!.remove(key);
  }

  static Future<bool> clearData() async {
    return await sharedPreferences!.clear();
  }

  Future<bool> has({required String key}) async {
    return await _basicErrorHandling(
          () async {
        return sharedPreferences!.containsKey(key) &&
            sharedPreferences!.getString(key) != null &&
            sharedPreferences!.getString(key)!.isNotEmpty;
      },
    );
  }

  Future<T> _basicErrorHandling<T>(Future<T> Function() onSuccess) async {
    try {
      final T result = await onSuccess();
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
