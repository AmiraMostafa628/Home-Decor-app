import 'package:dartz/dartz.dart';
import 'package:decor/core/connection/failure.dart';
import 'package:decor/core/services/local_storage/cache_services.dart';
import 'package:decor/core/services/local_storage/cached_keys.dart';
import 'package:decor/core/type_def/type_def_either.dart';
import 'package:decor/feature/auth/data/data_sources/local_data_source/local_data_source.dart';
import 'package:decor/feature/auth/data/data_sources/remote_data_source/auth_remote_data_source.dart';
import 'package:decor/feature/auth/data/mapper/login_mapper.dart';
import 'package:decor/feature/auth/data/mapper/sign_up_mapper.dart';
import 'package:decor/feature/auth/domain/entities/login_entity.dart';
import 'package:decor/feature/auth/domain/entities/sign_up_entity.dart';
import 'package:decor/feature/auth/domain/entities/user_entity.dart';
import 'package:decor/feature/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final LocalDataSource localDataSource;

  AuthRepoImpl({
    required this.authRemoteDataSource,
    required this.localDataSource,
  });

  @override
  FutureFailure<UserEntity> login({required LoginEntity entity}) async {
    try {
      final result = await authRemoteDataSource.login(model: entity.toModel());

      await localDataSource.saveUserData(model: result);
      await CacheServices.saveCachedData(key: CachedKeys.loginKey, value: true);
      await CacheServices.saveCachedData(
        key: CachedKeys.uIdKey,
        value: result.uId,
      );

      return Right(result.toEntity());
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  FutureFailure<UserEntity> signUp({required SignUpEntity entity}) async {
    try {
      final result = await authRemoteDataSource.signUp(model: entity.toModel());

      return Right(result.toEntity());
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<void> logOut() async {
    await authRemoteDataSource.logOut();

    try {
      await localDataSource.removeUserData();
    } catch (_) {}

    try {
      await CacheServices.removeCacheData(key: CachedKeys.loginKey);
    } catch (_) {}

    try {
      await CacheServices.removeCacheData(key: CachedKeys.uIdKey);
    } catch (_) {}

    return;
  }
}
