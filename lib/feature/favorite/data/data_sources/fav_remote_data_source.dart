import 'package:decor/feature/home/data/models/product_model.dart';

abstract class FavRemoteDataSource{
  Future<bool> toggleFav({required ProductModel product});
  Future<List<ProductModel>> fetchFav();
}