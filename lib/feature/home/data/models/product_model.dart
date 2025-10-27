import 'package:decor/feature/home/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.category,
    required super.subcategory,
    required super.image,
    required super.isBestSeller,
    required super.isNewCollection,
  });

  factory ProductModel.fromJson(Map<String,dynamic> json){
    return ProductModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        category: json['category'],
        subcategory: json['subcategory'],
        image: json['image'],
        isBestSeller: json['isBestSeller'],
        isNewCollection: json['isNewCollection'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'subcategory': subcategory,
      'image': image,
      'isBestSeller': isBestSeller,
      'isNewCollection': isNewCollection,
    };
  }

}
