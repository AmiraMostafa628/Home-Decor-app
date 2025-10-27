import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

Future<void> saveSecureData({required String key, required String value}) async {
  await _flutterSecureStorage.write(key: key, value: value);
}

Future<String?> getSecureData({required String key}) async {
  return await _flutterSecureStorage.read(key: key);
}

Future<bool?> containSecureData({required String key}) async {
  return await _flutterSecureStorage.containsKey(key: key);
}


Future<void> deleteSecureItem({required String key}) async {
  await _flutterSecureStorage.delete(key: key);
}

Future<void> deleteAllSecureData() async {
  await _flutterSecureStorage.deleteAll();
}
