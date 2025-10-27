import 'package:decor/feature/home/data/models/product_model.dart';

abstract class CartRemoteDataSource{
  Future<bool> toggleCart({required ProductModel product});
  Future<List<ProductModel>> fetchCart();
}