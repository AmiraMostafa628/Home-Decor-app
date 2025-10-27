import 'package:decor/core/components/custom_text_button.dart';
import 'package:decor/core/resources/app_constants.dart';
import 'package:decor/core/resources/color_manager.dart';
import 'package:decor/core/services/router/app_router.dart';
import 'package:decor/feature/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:decor/feature/profile/presentation/bloc/profile_bloc/profile_event.dart';
import 'package:decor/feature/profile/presentation/bloc/profile_bloc/profile_state.dart';
import 'package:decor/feature/home/presentation/widgets/shared/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            spacing: 40.0,
            children: [
              const CustomAppBar(title: 'Payment Methods'),
              Expanded(
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return Column(
                      children:
                          AppConstants.paymentMethodItems
                              .map((item) {
                                return ListTile(
                                  iconColor: ColorManager.primaryColor,
                                  titleTextStyle: textTheme.titleMedium,
                                  leading: Icon(item.icon, size: 30),
                                  title: Text(item.method),
                                  trailing: Radio<String>(
                                    value: item.method,
                                    activeColor: ColorManager.darkPrimaryColor,
                                    groupValue: state.selectedPaymentMethod,
                                    onChanged: (value) {
                                      ProfileBloc.get(context).add(
                                        ChangePaymentMethodEvent(
                                          selectedPaymentMethod: value!,
                                        ),
                                      );
                                    },
                                  ),
                                  onTap: () {
                                    ProfileBloc.get(context).add(
                                      ChangePaymentMethodEvent(
                                        selectedPaymentMethod: item.method,
                                      ),
                                    );
                                  },
                                );
                              })
                              .expand(
                                (widget) => [
                                  widget,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: Divider(
                                      color: ColorManager.primaryColor,
                                      height: 40,
                                      thickness: 1.0,
                                    ),
                                  ),
                                ],
                              )
                              .toList()
                            ..removeLast(),
                    );
                  },
                ),
              ),
              CustomTextButton(
                upperCase: false,
                onPressed: (){
                  GoRouter.of(context).push(AppRouter.kAddNewCardView);

                },
                width: 250,
                text: 'Add New Card',
              ),
              SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}
