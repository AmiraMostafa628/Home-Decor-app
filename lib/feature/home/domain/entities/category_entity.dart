import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String name;
  final String image;
  final List<dynamic> subcategories;

  const CategoryEntity({
    required this.name,
    required this.image,
    required this.subcategories,
  });

  @override
  List<Object?> get props => [name, image, subcategories];
}
