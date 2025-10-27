import 'package:decor/feature/home/domain/entities/product_entity.dart';
import 'package:decor/feature/home/presentation/widgets/shared/product_item.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NewCollectionsLoadingSection extends StatelessWidget {
  const NewCollectionsLoadingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Skeletonizer(
          enabled: true,
          child: ProductItem(
            product: ProductEntity(
              name: 'n$index',
              description: 'd$index',
              price: index,
              isBestSeller: false,
              isNewCollection: false,
              image: 'i$index',
              id: 0,
              category: '',
              subcategory: '',
            ),
          ),
        ),
        childCount: 4,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12.0,
        crossAxisSpacing: 12.0,
        childAspectRatio: .65,
      ),
    );
  }
}
