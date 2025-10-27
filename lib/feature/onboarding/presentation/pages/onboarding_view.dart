import 'package:decor/core/components/custom_text_button.dart';
import 'package:decor/core/components/scroll_indicator.dart';
import 'package:decor/core/services/local_storage/cache_services.dart';
import 'package:decor/core/services/local_storage/cached_keys.dart';
import 'package:decor/core/services/router/app_router.dart';
import 'package:decor/feature/onboarding/presentation/manager/onboarding_bloc/onboarding_bloc.dart';
import 'package:decor/feature/onboarding/presentation/manager/onboarding_bloc/onboarding_event.dart';
import 'package:decor/feature/onboarding/presentation/manager/onboarding_bloc/onboarding_state.dart';
import 'package:decor/feature/onboarding/presentation/widgets/onboarding_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:decor/core/resources/app_constants.dart';
import 'package:go_router/go_router.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => OnboardingBloc(),
        child: BlocConsumer<OnboardingBloc, OnboardingState>(
          listener: (context, state) async {
            if (state.currentIndex ==
                AppConstants.items.length - 1) {
             await CacheServices.saveCachedData(key: CachedKeys.onBoardingKey, value: true);
             if(context.mounted) {
               GoRouter.of(context).go(AppRouter.kLoginView);
             }
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (value) {
                      OnboardingBloc.get(context).add(
                        ChangeCurrentOnboardingIndexEvent(
                            currentIndex: value),
                      );
                    },
                    itemCount: AppConstants.items.length,
                    itemBuilder: (context, index) {
                      return OnboardingItem(
                          item: AppConstants.items[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ScrollIndicator(
                        currentIndex: state.currentIndex,
                        itemLength: AppConstants.items.length,
                      ),
                      CustomTextButton(
                        text: "next",
                        onPressed: () async {
                          if (state.currentIndex ==
                              AppConstants.items.length - 1) {
                            CacheServices.saveCachedData(
                                key: CachedKeys.onBoardingKey, value: true);
                            GoRouter.of(context).go(AppRouter.kLoginView);
                          } else {
                            _pageController.animateToPage(
                              state.currentIndex + 1,
                              duration: Duration(seconds: 1),
                              curve: Curves.easeIn,
                            );
                          }
                        },
                        width: 170,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),

              ],
            );
          },
        ),
      ),
    );
  }
}
