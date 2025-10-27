import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor/core/connection/failure.dart';
import 'package:decor/feature/home/data/data_sources/remote_data_source/home_remote_data_source.dart';
import 'package:decor/feature/home/data/models/category_model.dart';
import 'package:decor/feature/home/data/models/product_model.dart';
import 'package:decor/feature/home/data/models/slider_model.dart';

class HomeRemoteDataSourceImpl  implements HomeRemoteDataSource {
  @override
  Future<List<ProductModel>> fetchProductsData() async {
    try {
      late List<ProductModel> productList;
      final result = await FirebaseFirestore.instance
          .collection('products')
          .get();

      productList = result.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productList;
    } catch (error) {
      throw ServerFailure(message: 'fetch products error: ${error.toString()}');
    }
  }

  @override
  Future<List<CategoryModel>> fetchCategoriesData() async {
    try {
      late List<CategoryModel> categoryList;
      final result = await FirebaseFirestore.instance
          .collection('categories')
          .get();

      categoryList = result.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();
      return categoryList;
    } catch (error) {
      throw ServerFailure(
        message: 'fetch Categories Data error: ${error.toString()}',
      );
    }
  }

  @override
  Future<List<SliderModel>> fetchSliderData() async {
    try {
      late List<SliderModel> sliderList;
      final result = await FirebaseFirestore.instance
          .collection('banners')
          .get();
      sliderList = result.docs
          .map((e) => SliderModel.fromJson(e.data()))
          .toList();

      return sliderList;
    } catch (error) {
      throw ServerFailure(
        message: 'fetch Sliders Data error: ${error.toString()}',
      );
    }
  }
}
