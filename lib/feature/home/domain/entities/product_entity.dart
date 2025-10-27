import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable{
  final int id;
  final String name;
  final String description;
  final num price;
  final String image;
  final String category;
  final String subcategory;
  final bool isBestSeller;
  final bool isNewCollection;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.subcategory,
    required this.image,
    required this.isBestSeller,
    required this.isNewCollection,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    category,
    subcategory,
    image,
    isBestSeller,
    isNewCollection,
  ];
}