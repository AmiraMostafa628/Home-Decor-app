import 'package:decor/core/resources/color_manager.dart';
import 'package:decor/core/services/router/app_router.dart';
import 'package:decor/feature/home/domain/entities/category_entity.dart';
import 'package:decor/feature/home/domain/entities/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

class GridSection extends StatelessWidget {
  GridSection({
    super.key, required this.categories,
  });


  final List<CategoryItem> items = [
    CategoryItem(crossAxis: 2, mainAxis: 1.5),
    CategoryItem(crossAxis: 2, mainAxis: 2.5),
    CategoryItem(crossAxis: 2, mainAxis: 3.5),
    CategoryItem(crossAxis: 2, mainAxis: 2.5),
    CategoryItem(crossAxis: 4, mainAxis: 1.5),
  ];

  final List<CategoryEntity> categories;


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,

      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;

        return StaggeredGridTile.count(
          crossAxisCellCount: item.crossAxis,
          mainAxisCellCount: item.mainAxis,

          child: InkWell(
            onTap: (){
              GoRouter.of(context).push(AppRouter.kSubCategoriesView,extra: categories[index]);

            },
            child: Card(
              color: ColorManager.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  categories[index].name,
                  style: textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}