import 'package:decor/core/components/custom_image.dart';
import 'package:decor/core/enums/request_state.dart';
import 'package:decor/core/resources/color_manager.dart';
import 'package:decor/core/services/router/app_router.dart';
import 'package:decor/feature/cart/presentation/manager/cart/cart_bloc.dart';
import 'package:decor/feature/cart/presentation/manager/cart/cart_event.dart';
import 'package:decor/feature/cart/presentation/manager/cart/cart_state.dart';
import 'package:decor/feature/favorite/presentation/manager/fav/fav_bloc.dart';
import 'package:decor/feature/favorite/presentation/manager/fav/fav_event.dart';
import 'package:decor/feature/favorite/presentation/manager/fav/fav_state.dart';
import 'package:decor/feature/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(AppRouter.kProductDetails, extra: product);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? ColorManager.lightPrimaryColor2
              : ColorManager.blackColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          spacing: 10.0,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(20.0),
              child: CustomImage(
                imageType: ImagesType.network,
                height: 150,
                width: double.infinity,
                boxFit: BoxFit.cover,
                imagePath: product.image,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 10.0,
                left: 10.0,
                bottom: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.0,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorManager.primaryColor,
                    ),
                  ),
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodySmall,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'E£ ${product.price.toString()}',
                        style: textTheme.bodyMedium!.copyWith(
                          color: ColorManager.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      BlocConsumer<FavBloc, FavState>(
                        listenWhen: (previous, current) =>
                            previous.toggleFavStatus != RequestState.loaded &&
                            current.toggleFavStatus == RequestState.loaded,
                        listener: (context, state) {
                          Fluttertoast.showToast(
                            msg: '${state.toggleFavMessage} Successfully',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 14.0,
                          );
                          FavBloc.get(context).add(FetchFavEvent());
                        },
                        builder: (context, state) {
                          final isInFav = state.fav.any(
                            (item) => item.id == product.id,
                          );
                          return GestureDetector(
                            onTap: () {
                              FavBloc.get(
                                context,
                              ).add(ToggleFavEvent(product: product));
                            },
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.secondary,
                              child: Icon(
                                isInFav
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 18,
                                color: isInFav
                                    ? Colors.red
                                    : Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 10.0),
                      BlocConsumer<CartBloc, CartState>(
                        listenWhen: (previous, current) =>
                            previous.toggleCartStatus != RequestState.loaded &&
                            current.toggleCartStatus == RequestState.loaded,
                        listener: (context, state) {

                            Fluttertoast.showToast(
                              msg: '${state.toggleCartMessage} Successfully',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 14.0,
                            );
                            CartBloc.get(context).add(FetchCartEvent());
                        },
                        builder: (context, state) {
                          final isInCart = state.cart.any(
                            (item) => item.id == product.id,
                          );
                          return GestureDetector(
                            onTap: () {
                              CartBloc.get(
                                context,
                              ).add(ToggleCartEvent(product: product));
                            },
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.secondary,
                              child: Icon(
                                isInCart ? Icons.check : Icons.add,
                                size: 18,
                                color: isInCart
                                    ? Colors.green
                                    : Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
