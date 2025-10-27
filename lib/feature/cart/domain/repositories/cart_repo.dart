import 'package:decor/core/type_def/type_def_either.dart';
import 'package:decor/feature/home/domain/entities/product_entity.dart';

abstract class CartRepo{
  FutureFailure<bool> toggleCart({ required ProductEntity product});
  FutureFailure<List<ProductEntity>> fetchCart();
}