import 'package:dartz/dartz.dart';
import 'package:decor/core/connection/failure.dart';
import 'package:decor/core/type_def/type_def_either.dart';
import 'package:decor/feature/auth/data/data_sources/local_data_source/local_data_source.dart';
import 'package:decor/feature/auth/data/models/user_model.dart';
import 'package:decor/feature/auth/domain/entities/user_entity.dart';
import 'package:decor/feature/home/domain/repositories/get_current_user_repo.dart';

class GetCurrentUserRepoImpl implements GetCurrentUserRepo {
  final LocalDataSource localDataSource;

  GetCurrentUserRepoImpl({required this.localDataSource});

  @override
  FutureFailure<UserEntity?> getCurrentUser() async {
    try {
      final UserModel? result = await localDataSource.getUserData();

      return Right(result!.toEntity());
    } catch (error) {
      throw ServerFailure(
        message: 'unexpected get current user error  ${error.toString()}',
      );
    }
  }
}
