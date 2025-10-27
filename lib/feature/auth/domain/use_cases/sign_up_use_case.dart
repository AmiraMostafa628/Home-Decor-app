import 'package:decor/core/type_def/type_def_either.dart';
import 'package:decor/core/use_case/base_use_case.dart';
import 'package:decor/feature/auth/domain/entities/sign_up_entity.dart';
import 'package:decor/feature/auth/domain/entities/user_entity.dart';
import 'package:decor/feature/auth/domain/repositories/auth_repo.dart';

class SignUpUseCase extends BaseUseCase<UserEntity,SignUpEntity>{
  final AuthRepository signUpRepository;
  SignUpUseCase({required this.signUpRepository});


  @override
  FutureFailure<UserEntity> call({required SignUpEntity param}) async{
    return await signUpRepository.signUp(entity: param);
  }


}