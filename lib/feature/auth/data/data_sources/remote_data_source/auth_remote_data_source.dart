import 'package:decor/feature/auth/data/models/login_model.dart';
import 'package:decor/feature/auth/data/models/sign_up_model.dart';
import 'package:decor/feature/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required LoginModel model});
  Future<UserModel> signUp({required SignUpModel model});
  Future<void> logOut();
}
