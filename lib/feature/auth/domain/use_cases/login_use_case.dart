import 'package:decor/core/type_def/type_def_either.dart';
import 'package:decor/core/use_case/base_use_case.dart';
import 'package:decor/feature/auth/domain/entities/login_entity.dart';
import 'package:decor/feature/auth/domain/entities/user_entity.dart';
import 'package:decor/feature/auth/domain/repositories/auth_repo.dart';


class LoginUseCase extends BaseUseCase<UserEntity,LoginEntity>{
  final AuthRepository loginRepository;
  LoginUseCase({required this.loginRepository});


  @override
  FutureFailure<UserEntity> call({required LoginEntity param}) async{
   return await loginRepository.login(entity: param);
  }


}