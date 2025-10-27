import 'package:decor/feature/favorite/presentation/widgets/fav_item.dart';
import 'package:decor/feature/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FavLoading extends StatelessWidget {
  const FavLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: ListView.separated(
          itemCount: 4,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) => FavItem(product:  ProductEntity(
            name: 'n$index',
            description: 'd$index',
            price: index,
            isBestSeller: false,
            isNewCollection: false,
            image: 'i$index',
            id: 0,
            category: '',
            subcategory: '',
          ),)
        ),
      ),
    );
  }
}
