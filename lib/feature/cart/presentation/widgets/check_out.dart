import 'package:decor/core/components/custom_text_button.dart';
import 'package:decor/core/resources/app_constants.dart';
import 'package:decor/core/resources/color_manager.dart';
import 'package:decor/core/services/router/app_router.dart';
import 'package:decor/feature/cart/domain/use_cases/checkout_data.dart';
import 'package:decor/feature/home/presentation/widgets/shared/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckoutScreen extends StatelessWidget {
  final CheckoutData data;

  const CheckoutScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          children: [
            CustomAppBar(title: 'Checkout'),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Shipping Address',
                style: textTheme.titleLarge!.copyWith(
                  color: ColorManager.darkPrimaryColor,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: ColorManager.lightPrimaryColor2,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.0,
                children: [
                  Text(
                    data.name,
                    style: textTheme.titleMedium!.copyWith(
                      color: ColorManager.primaryColor,
                    ),
                  ),
                  Text(data.address),
                  Text(data.phone),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Order Summary',
                style: textTheme.titleLarge!.copyWith(
                  color: ColorManager.darkPrimaryColor,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: ColorManager.lightPrimaryColor2,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: data.items
                        .map((item) => Text(item.name))
                        .toList(),
                  ),
                  Text('Total: \$${data.total.toStringAsFixed(2)}'),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Payment Method',
                style: textTheme.titleLarge!.copyWith(
                  color: ColorManager.darkPrimaryColor,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: ColorManager.lightPrimaryColor2,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: AppConstants.paymentMethodItems.map((item) {
                  return ListTile(
                    iconColor: ColorManager.primaryColor,
                    titleTextStyle: textTheme.titleMedium,
                    leading: Icon(item.icon, size: 30),
                    title: Text(item.method),
                    trailing: Radio<String>(
                      value: item.method,
                      activeColor: ColorManager.darkPrimaryColor,
                      groupValue: AppConstants.paymentMethodItems.first.method,
                      onChanged: (value) {},
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10.0),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Delivery Time',
                style: textTheme.titleMedium!.copyWith(
                  color: ColorManager.darkPrimaryColor,
                ),
              ),
            ),
            Text('Estimated Delivery: 1 Hour, 25 mins'),
            const SizedBox(height: 20.0),
            Align(
              alignment: Alignment.center,
              child: CustomTextButton(
                upperCase: false,
                width: 250,
                onPressed: () {
                  GoRouter.of(context).push(AppRouter.kFinishOrder);
                },
                text: 'Pay Now',
              ),
            ),

            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
