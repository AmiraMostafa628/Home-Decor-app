import 'package:decor/core/components/custom_text_button.dart';
import 'package:decor/core/resources/assets_manager.dart';
import 'package:decor/core/resources/color_manager.dart';
import 'package:decor/core/services/router/app_router.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_bloc.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_event.dart';
import 'package:decor/feature/home/presentation/manager/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FinishOrder extends StatelessWidget {
  const FinishOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10.0,
            children: [
              Image.asset(AssetsManager.progress),
              Text(
                'Thank You',
                style: textTheme.titleLarge!.copyWith(
                  color: ColorManager.darkPrimaryColor,
                ),
              ),
              Text('Your order is complete', style: textTheme.bodyMedium),
              const SizedBox(height: 20.0,),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return CustomTextButton(
                    upperCase: false,
                    onPressed: () {
                      HomeBloc.get(context).add(ChangeHomeNavigationBar(
                          selectedBottomNavbarIndex: 0));
                      GoRouter.of(context).push(AppRouter.kHomeView);
                    },
                    width: 250,
                    text: 'Return To Home',
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
