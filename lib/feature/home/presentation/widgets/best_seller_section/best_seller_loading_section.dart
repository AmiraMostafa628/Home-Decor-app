import 'package:decor/feature/home/domain/entities/product_entity.dart';
import 'package:decor/feature/home/presentation/widgets/best_seller_section/best_seller_item.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BestSellerLoadingSection extends StatelessWidget {
  const BestSellerLoadingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SizedBox(
        height: 170,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          itemBuilder: (context, index) {
            return BestSellerItem(
              bestSeller: ProductEntity(
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
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            width: 20.0,
          ),
          itemCount: 5,
        ),
      ),
    );
  }
}
