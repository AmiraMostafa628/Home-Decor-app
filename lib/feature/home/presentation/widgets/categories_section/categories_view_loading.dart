import 'package:decor/feature/home/domain/entities/category_entity.dart';
import 'package:decor/feature/home/presentation/widgets/categories_section/grid_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoriesViewLoading extends StatelessWidget {
  const CategoriesViewLoading({super.key});

  @override
  Widget build(BuildContext context) {

    final fakeCategories = List.generate(
      5,
          (index) => CategoryEntity(name: '', subcategories: [], image: ''),
    );

    return Skeletonizer(
      enabled: true,
      child: GridSection(categories: fakeCategories),
    );
  }
}

