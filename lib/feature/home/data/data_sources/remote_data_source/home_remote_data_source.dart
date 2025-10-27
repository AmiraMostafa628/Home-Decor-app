import 'package:decor/feature/home/data/models/category_model.dart';
import 'package:decor/feature/home/data/models/product_model.dart';
import 'package:decor/feature/home/data/models/slider_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<ProductModel>> fetchProductsData();
  Future<List<CategoryModel>> fetchCategoriesData();
  Future<List<SliderModel>> fetchSliderData();
}
