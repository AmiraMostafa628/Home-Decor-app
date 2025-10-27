import 'package:decor/core/type_def/type_def_either.dart';
import 'package:decor/feature/auth/domain/entities/user_entity.dart';

abstract class GetCurrentUserRepo {
  FutureFailure<UserEntity?> getCurrentUser();
}