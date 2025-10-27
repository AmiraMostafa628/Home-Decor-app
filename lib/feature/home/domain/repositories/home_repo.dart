import 'package:decor/core/type_def/type_def_either.dart';
import 'package:decor/feature/home/domain/entities/category_entity.dart';
import 'package:decor/feature/home/domain/entities/product_entity.dart';
import 'package:decor/feature/home/domain/entities/slider_entity.dart';

abstract class HomeRepo{
  FutureFailure<List<ProductEntity>> fetchProducts();
  FutureFailure<List<CategoryEntity>> fetchCategories();
  FutureFailure<List<SliderEntity>> fetchSlider();
}