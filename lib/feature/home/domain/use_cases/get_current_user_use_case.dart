import 'package:decor/core/type_def/type_def_either.dart';
import 'package:decor/core/use_case/base_use_case.dart';
import 'package:decor/feature/auth/domain/entities/user_entity.dart';
import 'package:decor/feature/home/domain/repositories/get_current_user_repo.dart';

class GetCurrentUserUseCase extends BaseUseCase<UserEntity?, NoParam> {
  final GetCurrentUserRepo currentUserRepo;

  GetCurrentUserUseCase({required this.currentUserRepo});

  @override
  FutureFailure<UserEntity?> call({required NoParam param}) async {
    return await currentUserRepo.getCurrentUser();
  }
}
