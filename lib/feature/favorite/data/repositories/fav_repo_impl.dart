import 'package:dartz/dartz.dart';
import 'package:decor/core/connection/failure.dart';
import 'package:decor/core/type_def/type_def_either.dart';
import 'package:decor/feature/favorite/data/data_sources/fav_remote_data_source.dart';
import 'package:decor/feature/favorite/domain/repositories/fav_repo.dart';
import 'package:decor/feature/home/data/mapper/product_mapper.dart';
import 'package:decor/feature/home/domain/entities/product_entity.dart';

class FavRepoImpl implements FavRepo {
  final FavRemoteDataSource favRemoteDataSource;

  FavRepoImpl({required this.favRemoteDataSource});

  @override
  FutureFailure<bool> toggleFav({required ProductEntity product}) async {
    try {
      final result = await favRemoteDataSource.toggleFav(product: product.toModel());

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  FutureFailure<List<ProductEntity>> fetchFav() async {
    try {
      final result = await favRemoteDataSource.fetchFav();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
