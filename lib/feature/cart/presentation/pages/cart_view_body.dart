import 'package:decor/core/components/custom_text_button.dart';
import 'package:decor/core/enums/request_state.dart';
import 'package:decor/core/resources/assets_manager.dart';
import 'package:decor/core/resources/color_manager.dart';
import 'package:decor/core/services/router/app_router.dart';
import 'package:decor/feature/cart/domain/use_cases/checkout_data.dart';
import 'package:decor/feature/cart/presentation/manager/cart/cart_bloc.dart';
import 'package:decor/feature/cart/presentation/manager/cart/cart_state.dart';
import 'package:decor/feature/cart/presentation/widgets/cart_item.dart';
import 'package:decor/feature/cart/presentation/widgets/cart_loading.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_bloc.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_state.dart';
import 'package:decor/feature/home/presentation/widgets/shared/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final cart = state.cart;
          final subtotal = cart.fold<double>(
            0.0,
            (sum, item) => sum + item.price,
          );
          const taxAndFees = 400.0;
          const delivery = 200.0;
          final total = subtotal + taxAndFees + delivery;
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: [
                const CustomAppBar(title: 'Cart'),
                const SizedBox(height: 20),
                if (state.fetchCartStatus == RequestState.loading)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: CartLoading(),
                  )
                else if (cart.isEmpty)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Column(
                      spacing: 20.0,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AssetsManager.emptyCart),
                        Text('Your cart is empty', style: textTheme.bodyLarge),
                      ],
                    ),
                  )
                else
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: ListView.separated(
                          itemCount: cart.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final product = cart[index];
                            return CartItem(product: product);
                          },
                        ),
                      ),
                      Divider(
                        color: ColorManager.primaryColor,
                        height: 20,
                        thickness: 1.0,
                      ),
                      Column(
                        children: [
                          ListTile(
                            title: Text('SubTotal:'),
                            trailing: Text(
                              'E£ ${subtotal.toStringAsFixed(2)}',
                              style: textTheme.bodyMedium!.copyWith(
                                color: ColorManager.darkPrimaryColor,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text('Tax and Fees:'),
                            trailing: Text(
                              'E£ ${taxAndFees.toStringAsFixed(2)}',
                              style: textTheme.bodyMedium!.copyWith(
                                color: ColorManager.darkPrimaryColor,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text('Delivery:'),
                            trailing: Text(
                              'E£ ${delivery.toStringAsFixed(2)}',
                              style: textTheme.bodyMedium!.copyWith(
                                color: ColorManager.darkPrimaryColor,
                              ),
                            ),
                          ),
                          Divider(
                            color: ColorManager.primaryColor,
                            height: 20,
                            thickness: 1.0,
                          ),
                          ListTile(
                            title: Text('Total:'),
                            trailing: Text(
                              'E£ ${total.toStringAsFixed(2)}',
                              style: textTheme.bodyMedium!.copyWith(
                                color: ColorManager.darkPrimaryColor,
                              ),
                            ),
                          ),
                          BlocBuilder<HomeBloc, HomeState>(
                            builder: (context, state) {
                              return CustomTextButton(
                                width: 200,
                                onPressed: () {
                                  final checkout = CheckoutData(
                                    name: state.currentUser.userName!,
                                    address:
                                        '2464 Royal Ln. Mesa, New Jersey 45463',
                                    phone: state.currentUser.mobileNumber!,
                                    items: cart,
                                    total: total,
                                  );
                                  GoRouter.of(
                                    context,
                                  ).push(AppRouter.kCheckOut, extra: checkout);
                                },
                                text: 'Check Out',
                                upperCase: false,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
