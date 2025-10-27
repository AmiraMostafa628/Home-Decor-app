import 'package:decor/core/type_def/type_def_either.dart';
import 'package:decor/feature/auth/domain/entities/login_entity.dart';
import 'package:decor/feature/auth/domain/entities/sign_up_entity.dart';
import 'package:decor/feature/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  FutureFailure<UserEntity> login({required LoginEntity entity});
  FutureFailure<UserEntity> signUp({required SignUpEntity entity});
  Future<void> logOut();
}

