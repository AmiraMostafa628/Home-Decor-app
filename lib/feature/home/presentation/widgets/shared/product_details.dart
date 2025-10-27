import 'package:decor/core/components/custom_text_button.dart';
import 'package:decor/core/components/rating_widget.dart';
import 'package:decor/core/enums/request_state.dart';
import 'package:decor/core/resources/color_manager.dart';
import 'package:decor/feature/cart/presentation/manager/cart/cart_bloc.dart';
import 'package:decor/feature/cart/presentation/manager/cart/cart_event.dart';
import 'package:decor/feature/cart/presentation/manager/cart/cart_state.dart';
import 'package:decor/feature/favorite/presentation/manager/fav/fav_bloc.dart';
import 'package:decor/feature/favorite/presentation/manager/fav/fav_event.dart';
import 'package:decor/feature/favorite/presentation/manager/fav/fav_state.dart';
import 'package:decor/feature/home/domain/entities/product_entity.dart';
import 'package:decor/feature/home/presentation/widgets/shared/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.productItem});

  final ProductEntity productItem;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: productItem.category),
              const SizedBox(height: 45),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    productItem.image,
                    width: 300,
                    height: 250,
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                productItem.name,
                style: textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                productItem.description,
                style: textTheme.bodySmall!.copyWith(),
              ),
              Divider(
                color: ColorManager.primaryColor,
                height: 70,
                thickness: 2.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'E£ ${productItem.price}',
                    style: textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  BlocConsumer<FavBloc, FavState>(
                    listenWhen: (previous, current) =>
                        previous.toggleFavStatus != RequestState.loaded &&
                        current.toggleFavStatus == RequestState.loaded,
                    listener: (context, state) {
                      Fluttertoast.showToast(
                        msg: '${state.toggleFavStatus} Successfully',
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
                        (item) => item.id == productItem.id,
                      );
                      return GestureDetector(
                        onTap: () {
                          FavBloc.get(
                            context,
                          ).add(ToggleFavEvent(product: productItem));
                        },
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.secondary,
                          child: Icon(
                            isInFav ? Icons.favorite : Icons.favorite_border,
                            size: 18,
                            color: isInFav
                                ? Colors.red
                                : Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('User Review', style: textTheme.bodyLarge),
                  StarRating(rating: 4.5),
                ],
              ),
              const SizedBox(height: 40),
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
                    (item) => item.id == productItem.id,
                  );
                  return Center(
                    child: SizedBox(

                      child: CustomTextButton(
                        upperCase: false,
                        width: 200,
                        onPressed: () {
                          CartBloc.get(
                            context,
                          ).add(ToggleCartEvent(product: productItem));
                        },
                        text: isInCart ? 'Already in Cart' : 'Add to Cart',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
