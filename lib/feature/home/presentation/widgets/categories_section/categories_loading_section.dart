import 'package:decor/feature/home/domain/entities/category_entity.dart';
import 'package:decor/feature/home/presentation/widgets/categories_section/categories_item_builder.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoriesLoadingSection extends StatelessWidget {
  const CategoriesLoadingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SizedBox(
        height: 100,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return CategoriesItemBuilder(
              data: CategoryEntity(
                name: 'ttt$index',
                image: 'iii$index',
                subcategories: [],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 10.0),
          itemCount: 8,
        ),
      ),
    );
  }
}
