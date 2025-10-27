import 'package:equatable/equatable.dart';

class CategoryItem extends Equatable{
  final int crossAxis;
  final num mainAxis;

  const CategoryItem({
    required this.crossAxis,
    required this.mainAxis,

  });

  @override
  List<Object?> get props => [crossAxis,mainAxis];
}