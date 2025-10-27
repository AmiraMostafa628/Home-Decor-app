import 'package:decor/feature/home/data/models/product_model.dart';
import 'package:decor/feature/home/domain/entities/product_entity.dart';

extension ProductMapper on ProductEntity {
  ProductModel toModel() {
    return ProductModel(
      id: id,
      name: name,
      description: description,
      price: price,
      category: category,
      subcategory: subcategory,
      image: image,
      isBestSeller: isBestSeller,
      isNewCollection: isNewCollection,
    );
  }
}
