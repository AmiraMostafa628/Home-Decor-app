import 'package:decor/core/components/custom_image.dart';
import 'package:decor/core/resources/assets_manager.dart';
import 'package:decor/core/resources/color_manager.dart';
import 'package:decor/core/services/router/app_router.dart';
import 'package:decor/feature/cart/presentation/manager/cart/cart_bloc.dart';
import 'package:decor/feature/cart/presentation/manager/cart/cart_event.dart';
import 'package:decor/feature/cart/presentation/manager/cart/cart_state.dart';
import 'package:decor/feature/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: (){
        GoRouter.of(context).push(AppRouter.kProductDetails,extra: product);
      },
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: SizedBox(
                width: 90,
                height: 90,
                child: CustomImage(
                  imageType: ImagesType.network,
                  imagePath: product.image,
                ),
              ),
            ),
            const SizedBox(width: 15.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.name,
                    style: textTheme.bodyLarge!.copyWith(
                      color: ColorManager.darkPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('E£ ${product.price}', style: textTheme.bodyMedium),
                ],
              ),
            ),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    CartBloc.get(context).add(ToggleCartEvent(product: product));
                  },
                  icon: ImageIcon(
                    AssetImage(AssetsManager.emptyTrash),
                    size: 22,
                    color: ColorManager.darkPrimaryColor,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
