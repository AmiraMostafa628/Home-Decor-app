import 'package:decor/core/use_case/base_use_case.dart';
import 'package:decor/feature/auth/domain/repositories/auth_repo.dart';

class LogoutUseCase {
  final AuthRepository logoutRepository;

  LogoutUseCase({required this.logoutRepository});

  Future<void> call({required NoParam param}) async {
    return await logoutRepository.logOut();
  }
}
