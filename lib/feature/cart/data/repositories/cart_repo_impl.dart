import 'package:dartz/dartz.dart';
import 'package:decor/core/connection/failure.dart';
import 'package:decor/core/type_def/type_def_either.dart';
import 'package:decor/feature/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:decor/feature/cart/domain/repositories/cart_repo.dart';
import 'package:decor/feature/home/data/mapper/product_mapper.dart';
import 'package:decor/feature/home/domain/entities/product_entity.dart';

class CartRepoImpl implements CartRepo {
  final CartRemoteDataSource cartRemoteDataSource;

  CartRepoImpl({required this.cartRemoteDataSource});

  @override
  FutureFailure<bool> toggleCart({required ProductEntity product}) async {
    try {
     final result =  await cartRemoteDataSource.toggleCart(product: product.toModel());

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  FutureFailure<List<ProductEntity>> fetchCart() async {
    try {
      final result = await cartRemoteDataSource.fetchCart();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
