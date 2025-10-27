import 'package:dartz/dartz.dart';
import 'package:decor/core/connection/failure.dart';
import 'package:decor/core/type_def/type_def_either.dart';
import 'package:decor/feature/home/data/data_sources/remote_data_source/home_remote_data_source.dart';
import 'package:decor/feature/home/domain/entities/category_entity.dart';
import 'package:decor/feature/home/domain/entities/product_entity.dart';
import 'package:decor/feature/home/domain/entities/slider_entity.dart';
import 'package:decor/feature/home/domain/repositories/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImpl({required this.homeRemoteDataSource});

  @override
  FutureFailure<List<ProductEntity>> fetchProducts() async {
    try {
      final result = await homeRemoteDataSource.fetchProductsData();

      return right(result);
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  FutureFailure<List<CategoryEntity>> fetchCategories() async{
    try {
      final result = await homeRemoteDataSource.fetchCategoriesData();

      return right(result);
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  FutureFailure<List<SliderEntity>> fetchSlider() async {
    try {
      final result = await homeRemoteDataSource.fetchSliderData();

      return right(result);
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }
}
