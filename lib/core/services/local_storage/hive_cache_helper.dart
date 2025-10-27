import 'package:decor/core/services/local_storage/cached_keys.dart';
import 'package:decor/feature/auth/data/models/user_model.dart';
import 'package:hive_flutter/adapters.dart';

class HiveCacheHelper {
  static late Box<UserModel> userBox;

  static Future<void> initHive() async {
    userBox = await Hive.openBox<UserModel>('userBox');
  }

  static Future<void> saveUserModel(UserModel model) async {
    await userBox.put(CachedKeys.userModelKey, model);
  }

  static UserModel? getUserModel() {
    return userBox.get(CachedKeys.userModelKey);
  }

  static Future<void> removeUserModel() async {
    await userBox.delete(CachedKeys.userModelKey);
  }
}
