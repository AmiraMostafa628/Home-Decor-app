import 'package:decor/core/services/local_storage/hive_cache_helper.dart';
import 'package:decor/feature/auth/data/models/user_model.dart';

abstract class LocalDataSource {
  Future<void> saveUserData({required UserModel model});
  Future<UserModel?> getUserData();
  Future<void> removeUserData();
}

class LocalDataSourceImpl extends LocalDataSource {
  @override
  Future<void> saveUserData({required UserModel model}) async {
    await HiveCacheHelper.saveUserModel(model);
  }

  @override
  Future<UserModel?> getUserData() async {
    return HiveCacheHelper.getUserModel();
  }

  @override
  Future<void> removeUserData() async {
    await HiveCacheHelper.removeUserModel();
  }
}
